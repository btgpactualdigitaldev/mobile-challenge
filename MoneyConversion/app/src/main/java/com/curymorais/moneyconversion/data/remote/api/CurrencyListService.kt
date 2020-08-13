package com.curymorais.moneyconversion.data.remote.api

import com.curymorais.moneyconversion.data.remote.model.CurrencyListResponse
import com.curymorais.moneyconversion.data.remote.model.CurrencyPriceResponse
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyListService {

    @GET("list?access_key=b5527bd17591ddd6b673e19a85110e71&format=1")
    suspend fun getCurrencyList(): CurrencyListResponse

    @GET("live?access_key=b5527bd17591ddd6b673e19a85110e71")
    suspend fun getCurrencyPrice(): CurrencyPriceResponse

    @GET("live?access_key=b5527bd17591ddd6b673e19a85110e71")
    suspend fun getUSDValue(@Query("currencies") coin: String): CurrencyPriceResponse



}