package com.leonardocruz.btgteste.network

import com.leonardocruz.btgteste.model.CurrencyList
import com.leonardocruz.btgteste.model.CurrencyLive
import retrofit2.Response
import retrofit2.http.GET

interface BtgApi {

    @GET("list")
    suspend fun getApiList() : Response<CurrencyList>

    @GET("live")
    suspend fun getApiLive() : Response<CurrencyLive>
}