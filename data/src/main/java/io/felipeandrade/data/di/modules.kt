package io.felipeandrade.data.di

import io.felipeandrade.data.BuildConfig
import io.felipeandrade.data.CurrencyRepository
import io.felipeandrade.data.api.CurrencyApi
import io.felipeandrade.data.mapper.CurrencyMapper
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import org.koin.dsl.module
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit


val dataModule = module(override = true) {
    single { createOkHttpClient() }
    single { provideCurrencyApi(get()) }
    single { provideRetrofit(get()) }

    single { CurrencyRepository(get(), get()) }
    single { CurrencyMapper() }
}



fun provideRetrofit(okHttpClient: OkHttpClient): Retrofit {
    return Retrofit.Builder().baseUrl(BuildConfig.BASE_URL).client(okHttpClient)
        .addConverterFactory(GsonConverterFactory.create()).build()
}

fun createOkHttpClient(): OkHttpClient {
    val httpLoggingInterceptor = HttpLoggingInterceptor()
    httpLoggingInterceptor.level = HttpLoggingInterceptor.Level.BASIC
    return OkHttpClient.Builder()
        .connectTimeout(60L, TimeUnit.SECONDS)
        .readTimeout(60L, TimeUnit.SECONDS)
        .addInterceptor(httpLoggingInterceptor).build()
}

fun provideCurrencyApi(retrofit: Retrofit): CurrencyApi =
    retrofit.create(CurrencyApi::class.java)