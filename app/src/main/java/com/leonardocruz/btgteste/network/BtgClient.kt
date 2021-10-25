package com.leonardocruz.btgteste.network

import com.google.gson.GsonBuilder
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.converter.gson.GsonConverterFactory

object BtgClient {
    object Retrofit {
        inline fun <reified S> getInstance(baseUrl: String): S {
            return retrofit2.Retrofit.Builder()
                .baseUrl(baseUrl)
                .client(buildOkHttpClient())
                .addConverterFactory(GsonConverterFactory.create(GsonBuilder().create()))
                .build()
                .create(S::class.java)
        }

        fun buildOkHttpClient(): OkHttpClient {
            val okHttpClientBuilder = OkHttpClient.Builder()

            val interceptor = HttpLoggingInterceptor()
            interceptor.level = HttpLoggingInterceptor.Level.BODY
            okHttpClientBuilder.addInterceptor(interceptor)

            return okHttpClientBuilder.build()
        }
    }
}