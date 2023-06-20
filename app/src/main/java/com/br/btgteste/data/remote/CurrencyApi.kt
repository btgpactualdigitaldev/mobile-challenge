package com.br.btgteste.data.remote

import com.br.btgteste.data.model.CurrencyListDTO
import com.br.btgteste.data.model.CurrencyLiveDTO
import retrofit2.http.GET

interface CurrencyApi {

    @GET("list")
    suspend fun getCurrencyList(): CurrencyListDTO

    @GET("live")
    suspend fun getCurrencyLive(): CurrencyLiveDTO
}