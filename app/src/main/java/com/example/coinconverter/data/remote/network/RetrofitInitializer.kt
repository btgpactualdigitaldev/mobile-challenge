package com.example.coinconverter.data.remote.network

import com.example.coinconverter.data.remote.service.ConvertService
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RetrofitInitializer {
    var baseUrl: String = "https://btg-mobile-challenge.herokuapp.com/"
    val retrofit = Retrofit.Builder()
        .baseUrl(baseUrl)
        .addConverterFactory(GsonConverterFactory.create())
        .build()

    fun ConvertService(): ConvertService = retrofit.create(ConvertService::class.java)
}