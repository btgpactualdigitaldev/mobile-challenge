package com.sugarspoon.data.remote.services

import com.sugarspoon.data.remote.model.CurrenciesResponse
import com.sugarspoon.data.remote.model.RealTimeRatesResponse
import com.sugarspoon.desafiobtg.BuildConfig.ACCESS_KEY
import io.reactivex.Single
import retrofit2.http.GET
import retrofit2.http.Query

interface ExchangeRateService {

    @GET("list")
    fun getSupportedCurrencies(
        @Query("access_key")
        access_key: String = ACCESS_KEY
    ): Single<CurrenciesResponse>

    @GET("live")
    fun getRealTimeRates(
        @Query("access_key")
        access_key: String = ACCESS_KEY
    ): Single<RealTimeRatesResponse>

    @GET("convert")
    fun convertCurrency(
        @Query("access_key")
        access_key: String = ACCESS_KEY,
        @Query("&from")
        from: String,
        @Query("&to")
        to: String,
        @Query("&amount")
        amount: Float,
    ): Single<Any>
}