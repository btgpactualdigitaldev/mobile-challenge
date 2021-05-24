package com.mbarros64.btg_challenge.network.service

import com.mbarros64.btg_challenge.network.response.CurrencyListResponse
import retrofit2.Response
import retrofit2.http.GET


interface CurrencyList {
    @GET("list")
    suspend fun getCurrencyList() : Response<CurrencyListResponse>
}