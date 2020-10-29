package br.com.andreldsr.btgcurrencyconverter.infra.services

import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory

object ApiService{
    private fun initRetrofit(): Retrofit{
        return Retrofit.Builder()
                .baseUrl("http://api.currencylayer.com/")
                .addConverterFactory(
                        MoshiConverterFactory.create(
                                Moshi.Builder()
                                        .add(KotlinJsonAdapterFactory())
                                        .build()
                        )
                ).build()
    }

    val service: CurrencyService = initRetrofit().create(CurrencyService::class.java)
}