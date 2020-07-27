package com.example.challengecpqi.network.service

import com.google.gson.JsonObject
import retrofit2.http.GET

interface ListQuotesService {

    @GET("live")
    suspend fun getListQuotes(): JsonObject
}