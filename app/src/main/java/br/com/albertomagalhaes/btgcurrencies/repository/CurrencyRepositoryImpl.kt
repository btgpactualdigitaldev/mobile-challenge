package br.com.albertomagalhaes.btgcurrencies.repository

import br.com.albertomagalhaes.btgcurrencies.Constant
import br.com.albertomagalhaes.btgcurrencies.api.NetworkInterceptor
import br.com.albertomagalhaes.btgcurrencies.dao.CurrencyDAO
import br.com.albertomagalhaes.btgcurrencies.dto.CurrencyDTO
import com.btgpactual.currencyconverter.data.framework.retrofit.ClientAPI
import com.btgpactual.currencyconverter.data.framework.retrofit.response.CurrencyListResponse
import com.btgpactual.currencyconverter.data.framework.retrofit.response.QuoteListResponse
import retrofit2.Response
import retrofit2.awaitResponse
import java.util.*

class CurrencyRepositoryImpl(
    private val currencyDAO: CurrencyDAO,
    private val networkInterceptor: NetworkInterceptor
) :
    CurrencyRepository {

    override suspend fun hasCurrencyList() = if (currencyDAO.getCount() > 1) true else false

    override suspend fun getCurrencyList(onlySelected: Boolean) =
        if (onlySelected)
            currencyDAO.getByIsSelected(true)
        else
            currencyDAO.getAll()

    override suspend fun synchronizeCurrencyList(): ClientAPI.ResponseType {
        try {
            val clientAPI = ClientAPI(networkInterceptor).endpointAPI

            val responseCurrencyList: Response<CurrencyListResponse> =
                clientAPI.getCurrencyList().awaitResponse()
            val responseQuoteList: Response<QuoteListResponse> =
                clientAPI.getQuoteList().awaitResponse()

            if (
                responseCurrencyList.isSuccessful &&
                responseQuoteList.isSuccessful
            ) {
                responseCurrencyList.body()?.let { currencyList ->
                    responseQuoteList.body()?.let { quoteList ->
                        currencyDAO.apply {
                            val selectedList = getByIsSelected(true)
                            deleteAll()
                            currencyList.currencies.forEach {
                                insert(
                                    CurrencyDTO(
                                        code = it.key,
                                        name = it.value,
                                        value = quoteList.quotes.get("USD${it.key}") ?: 0.0,
                                        timestamp = Calendar.getInstance().timeInMillis
                                    )
                                )
                            }

                            selectedList?.forEach { updateByCodeAndIsSelected(it.code) }

                            return ClientAPI.ResponseType.Success<Any>()
                        }
                    }
                }
            }
            return ClientAPI.ResponseType.Fail.Unknown()
        } catch (e: NetworkInterceptor.NoInternetConnectionException) {
            return ClientAPI.ResponseType.Fail.NoInternet()
        }
    }

    override suspend fun updateCurrencyListSelected(
        currencyList: List<CurrencyDTO>,
        onSuccess: () -> Unit
    ) {
        currencyDAO.apply {
            clearSelection()
            currencyList.forEach {
                update(it)
            }
            onSuccess.invoke()
        }
    }

    override suspend fun setDefaultCurrencyListSeleted(
        onSuccess: () -> Unit
    ) {
        currencyDAO.apply {
            updateByCodeAndIsSelected(Constant.PRIMARY_CURRENCY)
            updateByCodeAndIsSelected(Constant.SECONDARY_CURRENCY)
            if (getCurrencySelectedCount() < 2) {
                clearSelection()
                getFirstN(2).forEach {
                    updateByCodeAndIsSelected(it.code)
                }
            }
            onSuccess.invoke()
        }
    }

}