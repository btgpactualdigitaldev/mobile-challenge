package com.gui.antonio.testebtg.retrofit

import com.google.gson.JsonObject
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyService {

    @GET("/list?access_key=058a196e52eb75faf4ec3f52a558647a&currencies=USD,AUD,CAD,PLN,MXN&format=1d")
    fun getListCurrency(): Call<JsonObject>

    @GET("/live?access_key=058a196e52eb75faf4ec3f52a558647a&format=1d")
    fun getQuote(@Query("currencies") symbols: String): Call<JsonObject>

    @GET("/live?access_key=058a196e52eb75faf4ec3f52a558647a&format=1d")
    fun getQuotes(@Query("currencies") symbols: List<String>): Call<JsonObject>

}