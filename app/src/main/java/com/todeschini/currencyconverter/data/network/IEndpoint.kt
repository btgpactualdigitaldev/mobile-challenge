package com.todeschini.currencyconverter.data.network

import com.todeschini.currencyconverter.model.CurrenciesListResponse
import com.todeschini.currencyconverter.model.LiveResponse
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Path

interface IEndpoint {

    @GET("/list")
    suspend fun getAllCurrencies() : Response<CurrenciesListResponse>

    @GET("/live/currencies/{currency}/source/USD/format/1")
    suspend fun getLiveCurrency(@Path("currency") currency: String): Response<LiveResponse>
}