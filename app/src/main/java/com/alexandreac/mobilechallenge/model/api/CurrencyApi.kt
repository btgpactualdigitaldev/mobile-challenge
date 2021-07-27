package com.alexandreac.mobilechallenge.model.api

import com.alexandreac.mobilechallenge.model.response.ConvertResponse
import com.alexandreac.mobilechallenge.model.response.CurrencyListResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Path
import retrofit2.http.Query

interface CurrencyApi {
    companion object {
        private const val ACCESS_KEY:String = "?access_key=f372a61fa052e38afd6bff40ad623a84"
    }

    @GET("list$ACCESS_KEY")
    fun listCurrencies():Call<CurrencyListResponse>

    @GET("live$ACCESS_KEY&currencies=")
    fun convert(@Query("currencies") currencies:String):Call<ConvertResponse>
}