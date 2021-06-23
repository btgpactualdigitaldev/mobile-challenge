package com.example.coinconverter.data.remote.service

import com.example.coinconverter.domain.model.Result
import retrofit2.http.GET

interface ConvertService {
    @GET("list")
    suspend fun listCurrencie(): Result

    @GET("live")
    suspend fun getLive() : Result
}
