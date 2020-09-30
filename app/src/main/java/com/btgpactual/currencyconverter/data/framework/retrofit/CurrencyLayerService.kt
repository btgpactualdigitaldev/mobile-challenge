package com.btgpactual.currencyconverter.data.framework.retrofit

import com.btgpactual.currencyconverter.data.framework.retrofit.response.CurrencyListResponse
import com.btgpactual.currencyconverter.data.framework.retrofit.response.QuoteListResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyLayerService {
    companion object {
        private const val KEY = "7d77da52294f64cc47aaa2435563f4bc"
    }

    @GET("list")
    fun getCurrencyList(
        @Query("access_key") key: String = KEY
    ): Call<CurrencyListResponse>

    @GET("live")
    fun getQuoteList(
        @Query("access_key") key: String = KEY
    ): Call<QuoteListResponse>

}