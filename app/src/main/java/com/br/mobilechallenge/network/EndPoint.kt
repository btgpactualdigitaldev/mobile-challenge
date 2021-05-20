package com.br.mobilechallenge.network

import com.br.mobilechallenge.model.ListResponse
import com.br.mobilechallenge.model.QuotesResponse
import retrofit2.http.GET
import retrofit2.http.Query

const val API_KEY = "dbe30439b1e4ce96b3ab8fd03ae5164a"

interface EndPoint {

    @GET("live")
    suspend fun getQuotes(
        @Query("access_key") key: String = API_KEY
    ): QuotesResponse


    @GET("list")
    suspend fun getCurrencyList(
        @Query("access_key") key: String = API_KEY
    ): ListResponse

}