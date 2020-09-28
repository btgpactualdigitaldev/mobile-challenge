package br.com.convertify.repository

import androidx.lifecycle.MutableLiveData
import br.com.convertify.api.ApiClient
import br.com.convertify.api.Constants
import br.com.convertify.api.DataState
import br.com.convertify.api.calls.QuantationApiInterface
import br.com.convertify.api.responses.QuotationApiResponse
import br.com.convertify.models.QuotationItem
import br.com.convertify.util.QuotationUtils
import retrofit2.Call
import retrofit2.Response
import javax.security.auth.callback.Callback

class QuotationRepository {
    fun fetchAvailableQuotations(): MutableLiveData< DataState<Array<QuotationItem>> > {
        val quotationLiveDataState: MutableLiveData<DataState<Array<QuotationItem>>> = MutableLiveData()

        val currencyApi = ApiClient.getRetrofitClient().create(QuantationApiInterface::class.java)
        val resource = DataState<Array<QuotationItem>>()

        currencyApi.getAvailableQuotation(Constants.API_KEY).enqueue(object : Callback,
            retrofit2.Callback<QuotationApiResponse> {
            override fun onResponse(
                call: Call<QuotationApiResponse>,
                response: Response<QuotationApiResponse>
            ) {
                try {
                    val currencyListMap = response.body()?.quotes!!
                    val currencyList = QuotationUtils.quotationMapToCurrencyList(currencyListMap)
                    resource.data = currencyList

                }catch (e: Exception){
                    resource.isError = true
                    resource.errorMessage = e.message
                }
                quotationLiveDataState.value = resource
            }

            override fun onFailure(call: Call<QuotationApiResponse>, t: Throwable) {
                resource.isError = true
                resource.errorMessage = t.message
                quotationLiveDataState.value = resource

            }

        })

        return quotationLiveDataState
    }
}