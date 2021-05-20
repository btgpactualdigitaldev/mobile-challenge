package com.maskow.currencyconverter.service

import com.maskow.currencyconverter.model.Currency
import retrofit2.Call
import retrofit2.http.GET

interface CurrencyService {
    @GET("/list?access_key=dbadc45416fffc8e3f7e4832a1b8eb95")
    fun list(): Call<Currency>

    @GET("/live?access_key=dbadc45416fffc8e3f7e4832a1b8eb95&format=1")
    fun convert(): Call<Currency>
}