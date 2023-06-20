package com.br.btgteste.data.remote

import com.br.btgteste.BuildConfig
import com.br.btgteste.data.model.CurrencyPayload
import com.br.btgteste.data.model.QuotePayload
import com.br.btgteste.data.remote.typeadapter.CurrenciesPayloadTypeAdapter
import com.br.btgteste.data.remote.typeadapter.QuotePayloadTypeAdapter
import com.google.gson.GsonBuilder
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RetrofitConfiguration() {

    private fun getRetrofit() =
        Retrofit.Builder()
            .baseUrl(BuildConfig.API_BASE_ENDPOINT)
            .addConverterFactory(getConverter())
            .client(OkHttpClient.Builder()
                    .addInterceptor(HttpInterceptor())
                    .addInterceptor(HttpLoggingInterceptor().apply {
                        level = HttpLoggingInterceptor.Level.BODY
                    })
                    .build())
            .build()

    fun getAppRequest(): CurrencyApi = getRetrofit().create(
        CurrencyApi::class.java)

    private fun getConverter(): GsonConverterFactory {
        val gson =
            GsonBuilder()
                .registerTypeAdapter(CurrencyPayload::class.java, CurrenciesPayloadTypeAdapter())
                .registerTypeAdapter(QuotePayload::class.java, QuotePayloadTypeAdapter())
                .create()

        return GsonConverterFactory.create(gson)
    }
}