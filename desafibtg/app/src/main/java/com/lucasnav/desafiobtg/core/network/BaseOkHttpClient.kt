package com.lucasnav.desafiobtg.core.network

import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import java.util.concurrent.TimeUnit

object BaseOkHttpClient {

    val defaultOkHttpClient: OkHttpClient = getOkHttpClientBuilder(
        HttpLoggingInterceptor.Level.BODY
    ).build()

    private fun getOkHttpClientBuilder(loggingLevel: HttpLoggingInterceptor.Level): OkHttpClient.Builder {
        val okHttpBuilder = OkHttpClient.Builder()

        with(okHttpBuilder) {
            connectTimeout(30, TimeUnit.SECONDS)
            writeTimeout(60, TimeUnit.SECONDS)
            readTimeout(60, TimeUnit.SECONDS)
        }

        return okHttpBuilder
    }
}