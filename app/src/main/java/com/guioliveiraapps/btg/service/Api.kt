package com.guioliveiraapps.btg.service

import com.guioliveiraapps.btg.response.CurrencyListResponse
import com.guioliveiraapps.btg.response.QuoteListResponse
import retrofit2.Call
import retrofit2.http.GET

interface Api {

    @GET("list")
    fun getCurrencies(): Call<CurrencyListResponse>

    @GET("live")
    fun getQuotes(): Call<QuoteListResponse>

}