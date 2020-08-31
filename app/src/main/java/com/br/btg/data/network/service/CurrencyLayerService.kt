package com.br.btg.data.network.service


import com.br.btg.data.models.ConverterModel
import com.br.btg.data.models.CurrencyLayerModel
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyLayerService {

    @GET("list")
    fun getAllExchangesRate(@Query("access_key") key: String): Call<CurrencyLayerModel>

    @GET("live")
    fun getConverter(@Query("access_key") key: String, @Query("currencies") currency: String, @Query("source") source: String, @Query("format") format: String): Call<ConverterModel>
}
