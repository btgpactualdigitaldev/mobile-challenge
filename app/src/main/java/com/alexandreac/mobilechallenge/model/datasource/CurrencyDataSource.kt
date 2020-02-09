package com.alexandreac.mobilechallenge.model.datasource

import com.alexandreac.mobilechallenge.model.data.Currency
import com.alexandreac.mobilechallenge.model.api.CurrencyApi
import com.alexandreac.mobilechallenge.model.response.ConvertResponse
import com.alexandreac.mobilechallenge.model.response.CurrencyListResponse
import com.alexandreac.mobilechallenge.util.round
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import kotlin.math.round

class CurrencyDataSource (val currencyApi: CurrencyApi):
    ICurrencyDataSource {
    override fun listAll(success: (List<Currency>) -> Unit, failure: (String) -> Unit) {
        val call = currencyApi.listCurrencies()
        call.enqueue(object: Callback<CurrencyListResponse>{
            override fun onResponse(call: Call<CurrencyListResponse>,
                                    response: Response<CurrencyListResponse>) {
                val resp = response.body()!!
                if(response.isSuccessful){
                    if(resp.success!!) {
                        val currencies = mutableListOf<Currency>()
                        response.body()?.currencies?.forEach {
                            currencies.add(
                                Currency(
                                    it.key,
                                    it.value
                                )
                            )
                        }
                        success(currencies)
                    } else {
                        failure(resp.error?.info!!)
                    }
                } else {
                    failure(resp.error?.info!!)
                }
            }

            override fun onFailure(call: Call<CurrencyListResponse>, t: Throwable) {
                failure(t.message!!)
            }

        })
    }

    override fun save(currency: Currency) {

    }

    override fun convert(currencies:String, fromValue:Double, success: (String) -> Unit, failure: (String) -> Unit) {
        val call = currencyApi.convert(currencies)
        call.enqueue(object : Callback<ConvertResponse>{
            override fun onResponse(call: Call<ConvertResponse>, response: Response<ConvertResponse>) {
                val resp = response.body()!!
                if(response.isSuccessful){
                    if(resp.success!!){
                        var convertion = 0.0
                        val quotes = mutableListOf<Double>()
                        response.body()?.quotes?.forEach {
                            quotes.add(it.value)
                        }
                        if(quotes.size > 1)
                            convertion = quotes[1]/quotes[0]
                        else
                            convertion = quotes[0]
                        var result = (fromValue*convertion).round(2)
                        success(result.toString())
                    } else {
                        failure(resp.error?.info!!)
                    }
                } else {
                    failure(resp.error?.info!!)
                }
            }
            override fun onFailure(call: Call<ConvertResponse>, t: Throwable) {
                failure(t.message!!)
            }
        })
    }
}