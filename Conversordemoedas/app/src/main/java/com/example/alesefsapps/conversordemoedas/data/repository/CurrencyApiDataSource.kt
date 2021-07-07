package com.example.alesefsapps.conversordemoedas.data.repository

import com.example.alesefsapps.conversordemoedas.data.ApiService.service
import com.example.alesefsapps.conversordemoedas.data.model.Currency
import com.example.alesefsapps.conversordemoedas.data.model.Quote
import com.example.alesefsapps.conversordemoedas.data.model.Values
import com.example.alesefsapps.conversordemoedas.data.response.ListCurrencyBodyResponse
import com.example.alesefsapps.conversordemoedas.data.result.CurrencyResult
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CurrencyApiDataSource : CurrencyRepository {

    private val apiKey: String = "eab8dae1f01e7d851435fe6c99f756f6"
    private val currencies: MutableList<Currency> = mutableListOf()

    override fun getCurrency(currenciesResultCallback: (result: CurrencyResult) -> Unit) {
        val call = service.getListCurrency(apiKey)

        call.enqueue(object : Callback<ListCurrencyBodyResponse> {
            override fun onResponse(
                call: Call<ListCurrencyBodyResponse>,
                response: Response<ListCurrencyBodyResponse>
            ) {
                when {
                    response.isSuccessful -> {
                        response.body()?.currencies?.let {
                            setCurrencyList(it)
                        }
                        currenciesResultCallback(CurrencyResult.Success(currencies))
                    }
                    else -> {
                        currenciesResultCallback(CurrencyResult.ApiError(response.code()))
                    }
                }
            }

            override fun onFailure(call: Call<ListCurrencyBodyResponse>, t: Throwable) {
                currenciesResultCallback(CurrencyResult.SeverError())
            }
        })
    }

    private fun setCurrencyList(currency: HashMap<String, String>) {
        for (key in currency.keys) {
            currencies.add(Currency(key, currency[key]))
        }
    }
}