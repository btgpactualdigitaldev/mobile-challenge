package com.example.challengesavio.api.services

import com.example.challengesavio.api.models.CurrenciesOutputs
import com.example.challengesavio.api.models.QuotesOutputs
import retrofit2.Call
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET

interface RetrofitService {

    @GET("/list")
    fun searchCurrencies(): Call<CurrenciesOutputs?>

    @GET("/live")
    fun searchQuotes(): Call<QuotesOutputs?>

    companion object {

        var retrofitService: RetrofitService? = null

        fun getInstance() : RetrofitService {

            if (retrofitService == null) {
                val retrofit = Retrofit.Builder()
                    .baseUrl("https://btg-mobile-challenge.herokuapp.com/")
                    .addConverterFactory(GsonConverterFactory.create())
                    .build()
                retrofitService = retrofit.create(RetrofitService::class.java)
            }
            return retrofitService!!
        }
    }
}