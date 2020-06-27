package com.btg.converter.data.remote.client

import com.btg.converter.data.remote.entity.ApiCurrencyList
import com.btg.converter.data.remote.entity.ApiCurrentQuotes
import retrofit2.Response
import retrofit2.http.GET

interface ApiService {

    @GET("list")
    suspend fun getCurrencyList(): Response<ApiCurrencyList>

    @GET("live")
    suspend fun getCurrentQuotes(): Response<ApiCurrentQuotes>
}