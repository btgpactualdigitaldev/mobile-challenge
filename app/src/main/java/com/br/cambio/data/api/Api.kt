package com.br.cambio.data.api

import com.br.cambio.data.model.Exchange
import retrofit2.Response
import retrofit2.http.GET

interface Api {

    @GET("/list")
    suspend fun getCurrency(
    ): Response<Exchange>

    @GET("/live")
    suspend fun getPrice(
    ): Response<Exchange>
}