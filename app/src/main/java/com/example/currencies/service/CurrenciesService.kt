package com.example.currencies.service

import com.example.currencies.model.remote.CurrenciesModelRemote
import retrofit2.Call
import retrofit2.http.GET

interface CurrenciesService {

    @GET("list")
    fun getAllCurrencies(): Call<CurrenciesModelRemote>
}