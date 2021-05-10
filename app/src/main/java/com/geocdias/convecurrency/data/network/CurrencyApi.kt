package com.geocdias.convecurrency.data.network

import com.geocdias.convecurrency.data.network.response.CurrencyListResponse
import com.geocdias.convecurrency.data.network.response.ExchangeRateResponse
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyApi {

    @GET("/live")
    suspend fun fetchRates(@Query("access_key") accessKey: String): Response<ExchangeRateResponse>

    @GET("/list")
    suspend fun fetchCurrencies(@Query("access_key") accessKey: String): Response<CurrencyListResponse>
}
