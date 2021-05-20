package com.maskow.currencyconverter.retrofit

import com.maskow.currencyconverter.service.CurrencyService
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class Retrofit {
    private val retrofit = Retrofit.Builder()
        .baseUrl("http://api.currencylayer.com")
        .addConverterFactory(GsonConverterFactory.create())
        .build()

    fun currencyService() = retrofit.create(CurrencyService::class.java)
}