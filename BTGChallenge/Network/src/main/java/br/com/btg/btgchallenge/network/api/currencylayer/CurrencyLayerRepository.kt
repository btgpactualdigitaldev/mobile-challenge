package br.com.btg.btgchallenge.network.api.currencylayer;


import android.content.Context
import br.com.btg.btgchallenge.network.api.config.Resource
import br.com.btg.btgchallenge.network.api.config.ResponseHandler
import br.com.btg.btgchallenge.network.model.ApiResponse
import br.com.btg.btgchallenge.network.model.currency.Currencies
import br.com.btg.btgchallenge.network.model.currency.Quotes
import com.instacart.library.truetime.TrueTime
import java.lang.Exception
import java.util.concurrent.atomic.AtomicIntegerFieldUpdater

class CurrencyLayerRepository(
    private val currencyLayerApi: CurrencyLayerServices,
    private val responseHandler: ResponseHandler,
    private val currencyRepositoryLocal: CurrencyRepositoryLocal,
    private val context: Context
) {

    suspend fun getCurrencies(): Resource<Any> {
        return try {
            val currencies = currencyRepositoryLocal.getCurrencies()
            var response = ApiResponse<Any>()
            if (currencies == null || currencies.currencies.isEmpty()) {
                response = currencyLayerApi.getCurrencies()
                currencyRepositoryLocal.insertCurrencies(Currencies(1, response.currencies, response.timestamp))
            } else {
                response.currencies = currencies.currencies
            }
            return responseHandler.handleSuccess(response)
        } catch (e: Exception) {
            responseHandler.handleException(e)
        }
    }

    suspend fun getRealTimeRates(): Resource<Any> {
        return try {
            val quotes = currencyRepositoryLocal.getQuotes()
            var response = ApiResponse<Any>()
            if (quotes == null || quotes.quotes.isEmpty()) {
                response = currencyLayerApi.getRealTimeRates()
                currencyRepositoryLocal.insertQuotes(Quotes(1, response.quotes, response.timestamp))
            } else {
                response.quotes = quotes.quotes
            }
            return responseHandler.handleSuccess(response)
        } catch (e: Exception) {
            responseHandler.handleException(e)
        }
    }
}