package com.btg.teste.repository.remote.service.currency

import com.btg.teste.entity.Currencies
import com.btg.teste.entity.CurrencyLayer
import com.btg.teste.repository.remote.iservice.ICurrencyLayer
import com.btg.teste.repository.remote.connect.URL
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class ServiceCurrencyLayer : IServiceCurrencyLayer {

    override fun currencyLayer(
        success: (currencyLayer: Response<CurrencyLayer?>) -> Unit,
        failure: (throwable: Throwable) -> Unit
    ) {
        val retrofit = Retrofit.Builder()
            .baseUrl(URL.WEB_SERVICE)
            .addConverterFactory(GsonConverterFactory.create())
            .build().create(ICurrencyLayer::class.java)

        val call = retrofit.currencyLayer(URL.KEY)
        call.enqueue(object : Callback<CurrencyLayer?> {
            override fun onResponse(call: Call<CurrencyLayer?>?, response: Response<CurrencyLayer?>?) {
                response?.let {
                    success.invoke(it)
                }
            }

            override fun onFailure(call: Call<CurrencyLayer?>?, t: Throwable) {
                failure.invoke(t)
            }
        })
    }


    override fun currencies(
        success: (currencies: Response<Currencies?>) -> Unit,
        failure: (throwable: Throwable) -> Unit
    ) {
        val retrofit = Retrofit.Builder()
            .baseUrl(URL.WEB_SERVICE)
            .addConverterFactory(GsonConverterFactory.create())
            .build().create(ICurrencyLayer::class.java)

        val call = retrofit.currencies(URL.KEY)
        call.enqueue(object : Callback<Currencies?> {
            override fun onResponse(call: Call<Currencies?>?, response: Response<Currencies?>?) {
                response?.let {
                    success.invoke(it)
                }
            }

            override fun onFailure(call: Call<Currencies?>?, t: Throwable) {
                failure.invoke(t)
            }
        })
    }
}
