package com.example.currencyconverter.remote

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

private const val BASE_URL = "https://btg-mobile-challenge.herokuapp.com/"

fun getRetrofit(): Retrofit {
    return Retrofit.Builder().baseUrl(BASE_URL).addConverterFactory(GsonConverterFactory.create())
        .build()
}

fun createCurrencyListService(retrofit: Retrofit): CurrencyList =
    retrofit.create(CurrencyList::class.java)

fun createRateService(retrofit: Retrofit): Rate =
    retrofit.create(Rate::class.java)