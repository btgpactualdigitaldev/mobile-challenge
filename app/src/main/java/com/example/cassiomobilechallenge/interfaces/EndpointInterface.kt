package com.example.cassiomobilechallenge.interfaces

import com.example.cassiomobilechallenge.models.CurrencyResponse
import com.example.cassiomobilechallenge.models.QuotesResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface EndpointInterface {

    @GET("list")
    fun getCurrencies(
        @Query("access_key") access_key: String,
        @Query("format") format: String
    ) : Call<CurrencyResponse>

    @GET("live")
    fun getAllConversions(
        @Query("access_key") access_key: String,
        @Query("format") format: String
    ) : Call<QuotesResponse>

    @GET("live")
    fun getConversion(
        @Query("access_key") access_key: String,
        @Query("format") format: String,
        @Query("currencies") currencies: String
    ) : Call<QuotesResponse>
}