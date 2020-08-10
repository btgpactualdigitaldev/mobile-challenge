package com.a.coinmaster.api.retrofit

import com.a.coinmaster.BuildConfig
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

class RetrofitConfig {

    fun <T> getServiceApi(apiClass: Class<T>): T =
        getBuild().create(apiClass)

    fun getBuild(): Retrofit =
        Retrofit
            .Builder()
            .baseUrl(BuildConfig.CURRENCYLAYER_URL_BASE)
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .addConverterFactory(GsonConverterFactory.create())
            .client(getHttpClient())
            .build()

    private fun getHttpClient(): OkHttpClient =
        OkHttpClient
            .Builder()
            .addInterceptor(getInterceptor())
            .connectTimeout(TIMEOUT, TimeUnit.SECONDS)
            .readTimeout(TIMEOUT, TimeUnit.SECONDS)
            .writeTimeout(TIMEOUT, TimeUnit.SECONDS)
            .build()

    private fun getInterceptor(): HttpLoggingInterceptor =
        HttpLoggingInterceptor()
            .apply {
                level = getInterceptorLevel()
            }

    private fun getInterceptorLevel() =
        if (BuildConfig.DEBUG) {
            HttpLoggingInterceptor.Level.BODY
        } else {
            HttpLoggingInterceptor.Level.NONE
        }

    companion object {
        const val TIMEOUT = 60L
    }
}