package com.mbarros64.btg_challenge.network

import com.mbarros64.btg_challenge.network.service.CurrencyList
import com.mbarros64.btg_challenge.network.service.CurrencyRate
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

private const val URL_BASE = "https://btg-mobile-challenge.herokuapp.com"

fun provideRetrofit() : Retrofit {
    return Retrofit.Builder()
        .baseUrl(URL_BASE)
        .addConverterFactory(GsonConverterFactory.create())
        .build()
}

fun provideCurrencyListService(retrofit: Retrofit) : CurrencyList = retrofit.create(CurrencyList::class.java)
fun provideCurrencyLiveService(retrofit: Retrofit) : CurrencyRate = retrofit.create(CurrencyRate::class.java)