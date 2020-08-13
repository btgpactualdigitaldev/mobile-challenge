package com.curymorais.moneyconversion.util

import com.curymorais.moneyconversion.data.remote.api.CurrencyListService
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RetrofitInitializer {

    val webservice: CurrencyListService by lazy {
        Retrofit.Builder()
            .baseUrl("http://api.currencylayer.com/")
            .addConverterFactory(GsonConverterFactory.create())
            .build().create(CurrencyListService::class.java)
    }
}