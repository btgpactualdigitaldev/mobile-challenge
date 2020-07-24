package com.desafio.btgpactual.http.service

import com.desafio.btgpactual.http.responses.CurrencyResponse
import com.desafio.btgpactual.http.responses.QuotesResponse
import retrofit2.Call
import retrofit2.http.GET

interface ApiService {
    @GET("list")
    fun list(): Call<CurrencyResponse>

    @GET("live")
    fun live(): Call<QuotesResponse>
}