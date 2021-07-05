package com.example.currencyconverter.remote

import retrofit2.Response
import retrofit2.http.GET

interface CurrencyList {

    @GET("list")
    suspend fun getCurrencyList(): Response<CurrencyListService>
}