package com.gui.antonio.testebtg.retrofit

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object RetrofitClient { val client = Retrofit.Builder().baseUrl("http://api.currencylayer.com/").addConverterFactory(GsonConverterFactory.create()).build().create(CurrencyService::class.java) }