package com.btgpactual.currencyconverter.data.framework.retrofit

import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory

class CurrencyLayerAPI(val networkConnectionInterceptor: NetworkConnectionInterceptor) {

    val client: OkHttpClient = OkHttpClient.Builder().apply {
        this.addInterceptor(networkConnectionInterceptor)
    }.build()

    private fun initRetrofit(): Retrofit {
        return Retrofit.Builder()
            .baseUrl(Companion.BASE_URL)
            .addConverterFactory(
                MoshiConverterFactory.create(
                    Moshi.Builder()
                        .add(KotlinJsonAdapterFactory())
                        .build()
                )
            )
            .client(client)
            .build()
    }

    val service: CurrencyLayerService = initRetrofit().create(CurrencyLayerService::class.java)

    companion object {
        private const val BASE_URL = "http://api.currencylayer.com/"
    }
}