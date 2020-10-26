package com.helano.network.services

import com.helano.network.responses.CurrenciesResponse
import com.helano.network.responses.QuotesResponse
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyLayerService {

    @GET("/list")
    suspend fun list(@Query("access_key") apiKey: String): CurrenciesResponse

    @GET("/live")
    suspend fun live(@Query("access_key") apiKey: String): QuotesResponse
}