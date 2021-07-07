package com.example.alesefsapps.conversordemoedas.data

import com.example.alesefsapps.conversordemoedas.data.response.ListCurrencyBodyResponse
import com.example.alesefsapps.conversordemoedas.data.response.LiveCurrencyBodyResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface ConverseServices {

    @GET("list")
    fun getListCurrency(
        @Query("access_key") apiKey: String
    ): Call<ListCurrencyBodyResponse>

    @GET("live")
    fun getLiveCurrency(
        @Query("access_key") apiKey: String
    ): Call<LiveCurrencyBodyResponse>
}
