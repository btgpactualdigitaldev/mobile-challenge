package com.example.desafiobtg.base

import com.example.desafiobtg.network.response.GetResponseApi

interface BaseRepository {
    suspend fun getListOfCurrencies(): GetResponseApi
    suspend fun getLivePrice(): GetResponseApi
}