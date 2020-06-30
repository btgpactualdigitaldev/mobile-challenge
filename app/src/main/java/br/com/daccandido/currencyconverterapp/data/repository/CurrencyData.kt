package br.com.daccandido.currencyconverterapp.data.repository


import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.ApiService
import br.com.daccandido.currencyconverterapp.data.ResultRequest
import br.com.daccandido.currencyconverterapp.data.model.ExchangeRate
import br.com.daccandido.currencyconverterapp.data.model.KEY_API_CURRENCIES
import br.com.daccandido.currencyconverterapp.data.model.QuoteRequest
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CurrencyData: CurrencyRepository {

    override suspend fun getListExchangeRate(callback: (result: ResultRequest) -> Unit) {

        withContext(Dispatchers.IO) {

            ApiService.service.getExchangeRate().enqueue(object : Callback<ExchangeRate> {
                override fun onFailure(call: Call<ExchangeRate>, t: Throwable) {
                    callback(ResultRequest.SeverError)
                }

                override fun onResponse(
                    call: Call<ExchangeRate>,
                    response: Response<ExchangeRate>
                ) {
                    when {
                        response.isSuccessful -> {
                            response.body()?.let {
                                callback(ResultRequest.SuccessExchangeRate(it))
                            } ?: run {
                                callback(ResultRequest.Error(R.string.error_not_exchange_rates))
                            }
                        }
                        else -> callback(ResultRequest.Error(R.string.error_not_exchange_rates))
                    }
                }
            })
        }
    }

    override suspend fun getAllQuote(callback: (result: ResultRequest) -> Unit) {

        withContext(Dispatchers.IO) {

            ApiService.service.getQuote(mapOf()).enqueue(object : Callback<QuoteRequest> {
                override fun onFailure(call: Call<QuoteRequest>, t: Throwable) {
                    callback(ResultRequest.SeverError)
                }

                override fun onResponse(call: Call<QuoteRequest>, response: Response<QuoteRequest>) {
                    when {
                        response.isSuccessful -> {
                            response.body()?.let {
                                callback(ResultRequest.SuccessQuote(it))
                            } ?: run {
                                callback(ResultRequest.Error(R.string.error_not_exchange_rates))
                            }
                        }
                        else -> callback(ResultRequest.Error(R.string.error_not_exchange_rates))
                    }
                }
            })
        }
    }

    override suspend fun getQuote(currenciyes: String, callback: (result: ResultRequest) -> Unit) {

        withContext(Dispatchers.IO) {

            ApiService.service.getQuote(mapOf(KEY_API_CURRENCIES to currenciyes))
                .enqueue(object : Callback<QuoteRequest> {
                    override fun onFailure(call: Call<QuoteRequest>, t: Throwable) {
                        callback(ResultRequest.SeverError)
                    }

                    override fun onResponse(
                        call: Call<QuoteRequest>,
                        response: Response<QuoteRequest>
                    ) {
                        when {
                            response.isSuccessful -> {
                                response.body()?.let {
                                    callback(ResultRequest.SuccessQuote(it))
                                } ?: run {
                                    callback(ResultRequest.Error(R.string.error_not_exchange_rates))
                                }
                            }
                            else -> callback(ResultRequest.Error(R.string.error_not_exchange_rates))
                        }
                    }
                })
        }
    }
}