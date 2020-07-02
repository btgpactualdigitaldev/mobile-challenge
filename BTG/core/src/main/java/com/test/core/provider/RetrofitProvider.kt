package com.test.core.provider

import com.google.gson.Gson
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

private val retrofit =
    Retrofit.Builder()
        .client(
            OkHttpClient.Builder()
                .connectTimeout(5000, TimeUnit.SECONDS)
                .readTimeout(10000, TimeUnit.SECONDS)
                .writeTimeout(15000, TimeUnit.SECONDS)
                .build()
        )
        .baseUrl("http://api.currencylayer.com")
        .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
        .addConverterFactory(GsonConverterFactory.create(Gson()))
        .build()


fun provideRetrofit(): Retrofit {
    return retrofit
}


