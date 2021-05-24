package com.mbarros64.btg_challenge.network.service

import com.mbarros64.btg_challenge.network.response.CurrencyRateResponse
import retrofit2.Response
import retrofit2.http.GET

interface CurrencyRate {
    @GET("live")
    suspend fun getCurrencyLive() : Response<CurrencyRateResponse>
}