package com.br.btg.data.network.webclient

import com.br.btg.data.network.service.CurrencyLayerService
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


private const val BASE_URL = "http://apilayer.net/api/"

class RetrofitClient {

        private val client by lazy {
            val interceptador = HttpLoggingInterceptor()
            interceptador.level = HttpLoggingInterceptor.Level.BODY
            OkHttpClient.Builder()
                .addInterceptor(interceptador)
                .build()
        }

        private val retrofit by lazy {
            Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .client(client)
                .build()
        }

        val currencyLayerService: CurrencyLayerService by lazy {
            retrofit.create(CurrencyLayerService::class.java)
        }

    }
