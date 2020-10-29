package br.com.andreldsr.btgcurrencyconverter.infra.services

import br.com.andreldsr.btgcurrencyconverter.infra.response.CurrencyListResponse
import br.com.andreldsr.btgcurrencyconverter.infra.response.QuoteListResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyService {
    @GET("list")
    fun getCurrency(@Query("access_key") accessKey: String = CurrencyService.accessKey): Call<CurrencyListResponse>

    @GET("live")
    fun getQuote(@Query("access_key") accessKey: String = CurrencyService.accessKey): Call<QuoteListResponse>

    companion object {
        const val accessKey = "f01a011b42c36a5f02c39853510bb4cb"
    }
}