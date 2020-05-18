package com.btg.teste.repository.remote.iservice

import com.btg.teste.entity.Currencies
import com.btg.teste.entity.CurrencyLayer
import retrofit2.Call
import retrofit2.http.*

interface ICurrencyLayer {

    @GET("live?")
    fun currencyLayer(@Query("access_key") key: String): Call<CurrencyLayer?>

    @GET("list?")
    fun currencies(@Query("access_key") key: String): Call<Currencies?>
}