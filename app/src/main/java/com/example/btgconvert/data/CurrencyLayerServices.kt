package com.example.btgconvert.data

import com.example.btgconvert.data.response.CurrencyListResponse
import com.example.btgconvert.data.response.QuotesResponce
import retrofit2.Call
import retrofit2.http.GET


interface CurrencyLayerServices {
    companion object{
        const val ACCESS_KEY = "f47f9cf5fb96f9da14a748ae9f74ff4f"
    }


    @GET("/list?access_key=$ACCESS_KEY")
    fun getCurrencies(): Call<CurrencyListResponse>

    @GET("/live?access_key=$ACCESS_KEY")
    fun getQuotes(): Call<QuotesResponce>
}