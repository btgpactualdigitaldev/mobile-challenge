package com.example.challengecpqi.network.config

import com.example.challengecpqi.network.service.ListCurrencyService
import com.example.challengecpqi.network.service.ListQuotesService
import com.example.challengecpqi.util.ACCESS_KEY
import com.example.challengecpqi.util.BASE_URL
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

class ServiceConfig(val connectivityInterceptor: ConnectivityInterceptor) {

    private var retrofit: Retrofit

    init {
        val logging = HttpLoggingInterceptor()
        logging.level = HttpLoggingInterceptor.Level.BODY
        val client = OkHttpClient.Builder()
        val requestInterceptor = Interceptor { chain ->

            val url = chain.request()
                .url()
                .newBuilder()
                .addQueryParameter("access_key", ACCESS_KEY)
                .build()
            val request = chain.request()
                .newBuilder()
                .url(url)
                .build()


            return@Interceptor chain.proceed(request)
        }

        val okHttpClient = OkHttpClient.Builder()
            .addInterceptor(requestInterceptor)
            .addInterceptor(connectivityInterceptor)
            .addInterceptor(logging)
            .connectTimeout(1000, TimeUnit.SECONDS)
            .readTimeout(1000, TimeUnit.SECONDS)
            .build()

            retrofit = Retrofit.Builder()
                .client(okHttpClient)
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .build()
    }

    val listCurrencyService: ListCurrencyService?
        get() = retrofit.create(ListCurrencyService::class.java)

    val listQuotesService: ListQuotesService?
        get() = retrofit.create(ListQuotesService::class.java)

}