package com.example.currencyconverter.remote

import retrofit2.Response
import retrofit2.http.GET

interface Rate {

    @GET("live")
    suspend fun getRateList(): Response<RateService>
}