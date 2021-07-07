package com.example.alesefsapps.conversordemoedas.data.repository

import com.example.alesefsapps.conversordemoedas.data.ApiService.service
import com.example.alesefsapps.conversordemoedas.data.model.Quote
import com.example.alesefsapps.conversordemoedas.data.response.LiveCurrencyBodyResponse
import com.example.alesefsapps.conversordemoedas.data.result.LiveValueResult
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.math.BigDecimal
import java.text.SimpleDateFormat

class ValueLiveApiDataSource : ValueLiveRepository {

    private val apiKey: String = "eab8dae1f01e7d851435fe6c99f756f6"
    private val quotes: MutableList<Quote> = mutableListOf()
    var timestamp: Int = 0

    override fun getValueLive(valueResultCallback: (result: LiveValueResult) -> Unit) {
        val call = service.getLiveCurrency(apiKey)

        call.enqueue(object : Callback<LiveCurrencyBodyResponse> {
            override fun onResponse(
                call: Call<LiveCurrencyBodyResponse>,
                response: Response<LiveCurrencyBodyResponse>
            ) {
                when {
                    response.isSuccessful -> {
                        response.body()?.quotes?.let {
                            setCurrencyLive(it)
                        }
                        response.body()?.timestamp?.let {
                            timestamp = it
                        }

                        valueResultCallback(LiveValueResult.Success(quotes, timestamp))
                    }
                    else -> {
                        valueResultCallback(LiveValueResult.ApiError(response.code()))
                    }
                }
            }

            override fun onFailure(call: Call<LiveCurrencyBodyResponse>, t: Throwable) {
                valueResultCallback(LiveValueResult.SeverError())
            }

        })
    }

    fun setCurrencyLive(quote: HashMap<String, BigDecimal>) {
        for (key in quote.keys) {
            quotes.add(Quote(key, quote[key]))
        }
    }
}