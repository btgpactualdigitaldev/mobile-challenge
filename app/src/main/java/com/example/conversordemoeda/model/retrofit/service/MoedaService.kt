package com.example.conversordemoeda.model.retrofit.service

import com.example.conversordemoeda.BuildConfig
import com.example.conversordemoeda.model.entidades.Cambio
import com.example.conversordemoeda.model.entidades.Cotacao
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface MoedaService {
    @GET("/list")
    fun getCambio(
        @Query("access_key") chave: String = BuildConfig.ACCESS_KEY
    ):Call<Cambio>

    @GET("/live")
    fun getCotacao(
        @Query("access_key") chave: String = BuildConfig.ACCESS_KEY
    ):Call<Cotacao>
}