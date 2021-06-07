package com.example.exchange.utils

import com.example.exchange.model.ListCoin
import com.example.exchange.model.LiveCoin
import retrofit2.Call
import retrofit2.http.GET

interface Endpoint {

    @GET("list")
    fun getListCoins(): Call<ListCoin>

    @GET("live")
    fun getLiveCoins(): Call<LiveCoin>
}