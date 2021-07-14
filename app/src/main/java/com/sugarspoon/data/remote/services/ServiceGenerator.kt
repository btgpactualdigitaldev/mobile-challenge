package com.sugarspoon.data.remote.services

import com.jakewharton.retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class ServiceGenerator {
    companion object {
        fun <S> createService(
            serviceClass: Class<S>,
            url: String
        ): S {
            val retrofit = Retrofit.Builder()
                .baseUrl(url)
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory (RxJava2CallAdapterFactory.create ())

            val httpClient = OkHttpClient.Builder()
            retrofit.client(httpClient.build())
            return retrofit.build().create(serviceClass)
        }
    }
}