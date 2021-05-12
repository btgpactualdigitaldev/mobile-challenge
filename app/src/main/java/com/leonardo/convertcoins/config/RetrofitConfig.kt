package com.leonardo.convertcoins.config

import com.leonardo.convertcoins.services.CurrencyService
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RetrofitConfig {
    /**
     * Setup retrofit with baseUrl and set Gson as the convert library which will deal with
     * serializing JSON data into Java objects
     */
    private val retrofit: Retrofit = Retrofit.Builder()
        .baseUrl("http://api.currencylayer.com/")
        .addConverterFactory(GsonConverterFactory.create())
        .build()

    /**
     * Exposes the api created on CurrencyService
     */
    fun currencyService(): CurrencyService = retrofit.create(CurrencyService::class.java)
}