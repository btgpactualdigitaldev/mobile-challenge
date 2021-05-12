package com.leonardo.convertcoins.services

import com.leonardo.convertcoins.models.RealtimeRates
import com.leonardo.convertcoins.models.SupportedCurrencies
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyService {
    @GET("live")
    fun getRealtimeRates(@Query("access_key") accessKey: String): Call<RealtimeRates>

    @GET("list")
    fun getSupportedCurrencies(@Query("access_key") accessKey: String): Call<SupportedCurrencies>
}