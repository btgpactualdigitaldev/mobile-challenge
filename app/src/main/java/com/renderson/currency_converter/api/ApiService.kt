package com.renderson.currency_converter.api

import com.renderson.currency_converter.models.CurrencyResponse
import com.renderson.currency_converter.models.QuotesResponse
import retrofit2.Response
import retrofit2.http.GET

interface ApiService {
    @GET("/list")
    suspend fun getAllCurrencies(): Response<CurrencyResponse>

    @GET("/live")
    suspend fun getAllQuotes(): Response<QuotesResponse>
}