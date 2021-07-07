package com.example.alesefsapps.conversordemoedas.data

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object ApiService {

    private const val BASE_URL: String = "http://api.currencylayer.com/"

    private fun initRetrofit(): Retrofit {
        return Retrofit.Builder()
            .baseUrl(BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }

    val service: ConverseServices = initRetrofit().create(ConverseServices::class.java)
}