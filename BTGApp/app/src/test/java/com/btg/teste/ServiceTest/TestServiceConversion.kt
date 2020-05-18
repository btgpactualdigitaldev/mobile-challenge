package com.btg.teste.ServiceTest

import com.btg.teste.entity.Currencies
import com.btg.teste.entity.CurrencyLayer
import com.btg.teste.repository.remote.connect.URL
import com.btg.teste.repository.remote.iservice.ICurrencyLayer
import com.btg.teste.repository.remote.service.currency.IServiceCurrencyLayer
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

@Experimental(Experimental.Level.ERROR)
annotation class TestConversionApi

@TestConversionApi
class TestServiceConversion : IServiceCurrencyLayer {

    override fun currencies(
        success: (currencyLayer: Response<Currencies?>) -> Unit,
        failure: (throwable: Throwable) -> Unit
    ) {
        val retrofit = Retrofit.Builder()
            .baseUrl(URL.WEB_SERVICE)
            .addConverterFactory(GsonConverterFactory.create())
            .build().create(ICurrencyLayer::class.java)

        val call = retrofit.currencies(URL.KEY).execute()

        if (call.isSuccessful) {
            success.invoke(call)
        } else {
            failure.invoke(Throwable(call.message()))
        }
    }

    override fun currencyLayer(
        success: (currencyLayer: Response<CurrencyLayer?>) -> Unit,
        failure: (throwable: Throwable) -> Unit
    ) {
        val retrofit = Retrofit.Builder()
            .baseUrl(URL.WEB_SERVICE)
            .addConverterFactory(GsonConverterFactory.create())
            .build().create(ICurrencyLayer::class.java)

        val call = retrofit.currencyLayer(URL.KEY).execute()

        if (call.isSuccessful) {
            success.invoke(call)
        } else {
            failure.invoke(Throwable(call.message()))
        }
    }
}