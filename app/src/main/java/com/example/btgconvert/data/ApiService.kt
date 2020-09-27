package com.example.btgconvert.data

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


object ApiService {
    private fun initRetrofit() : Retrofit{
        return Retrofit.Builder()
                .baseUrl("http://api.currencylayer.com")
                .addConverterFactory(GsonConverterFactory.create())
                .build()
    }

    val services:CurrencyLayerServices = initRetrofit().create(CurrencyLayerServices::class.java)
}


