package com.hotmail.fignunes.btg.repository.remote

import com.hotmail.fignunes.btg.BuildConfig
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory

class Api<T> {

    fun create(clazz: Class<T>): T {
        return Retrofit.Builder()
            .baseUrl(BuildConfig.BASE_URL)
            .client(createClientWithInterceptor())
            .addConverterFactory(GsonConverterFactory.create())
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .build()
            .create(clazz)
    }

    private fun createClientWithInterceptor(): OkHttpClient {
        return OkHttpClient.Builder()
            .addInterceptor(HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY))
            .addNetworkInterceptor { chain ->
                chain.proceed(
                    chain.request().newBuilder()
                        .addHeader("Content-Type", "application/json")
                        .build()
                )
            }
            .build()
    }
}