package io.felipeandrade.data.api

import io.felipeandrade.data.api.response.LiveCurrenciesResponse
import io.felipeandrade.data.api.response.SupportedCurrenciesResponse
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyApi {

    @GET("list")
    suspend fun loadSupportedCurrencies(@Query("access_key") apiKey: String): SupportedCurrenciesResponse

    @GET("live")
    suspend fun loadLiveCurrencies(
        @Query("access_key")    apiKey: String,
        @Query("source")        source: String,
        @Query("currencies")    currency: String
    ): LiveCurrenciesResponse

}