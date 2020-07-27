package com.example.challengecpqi.network.service

import com.google.gson.JsonObject
import retrofit2.http.GET

interface ListCurrencyService {

    @GET("list")
    suspend fun getListCurrency(): JsonObject
}