package com.romildosf.currencyconverter.datasource.rest

import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
class ApiServiceFactory {

    fun <T> createService(clazz: Class<T>, endpoint: String): T {
        val httpClient = OkHttpClient.Builder()

        return Retrofit.Builder()
            .baseUrl(endpoint)
            .addConverterFactory(GsonConverterFactory.create())
            .client(httpClient.build())
            .build()
            .create(clazz)
    }

}

