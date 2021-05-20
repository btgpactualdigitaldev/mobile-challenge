package com.renderson.currency_converter.di

import android.content.Context
import com.renderson.currency_converter.BuildConfig
import com.renderson.currency_converter.MyApplication
import com.renderson.currency_converter.api.ApiHelper
import com.renderson.currency_converter.api.ApiHelperImpl
import com.renderson.currency_converter.api.ApiService
import com.renderson.currency_converter.api.RequestInterceptor
import com.renderson.currency_converter.other.Constants
import com.renderson.currency_converter.other.getConnectType
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import okhttp3.Cache
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Singleton

@Module
@InstallIn(ApplicationComponent::class)
object AppModule {

    @Provides
    fun provideBaseUrl() = Constants.BASE_URL

    @Provides
    fun provideContext(): Context = MyApplication.getContext()

    @Provides
    fun provideCache() = Cache(provideContext().cacheDir, Constants.CACHE)

    @Provides
    fun provideConnection() = getConnectType(provideContext())

    @Singleton
    @Provides
    fun provideOkHHttpClient() = if (BuildConfig.DEBUG) {
        val loggingInterceptor = HttpLoggingInterceptor()
        loggingInterceptor.setLevel(HttpLoggingInterceptor.Level.BODY)
        OkHttpClient.Builder()
            .cache(provideCache())
            .addInterceptor(loggingInterceptor)
            .addNetworkInterceptor(RequestInterceptor())
            .addInterceptor { chain ->
                var request = chain.request()
                request = if (provideConnection())
                    request.newBuilder().header("Cache-Control", "public, max-age=${5}")
                        .build()
                else
                    request.newBuilder().header(
                        "Cache-control",
                        "public. only-i-cached, max-stale=${604800}")
                        .build()
                    chain.proceed(request)
            }
            .build()
    } else {
        OkHttpClient
            .Builder()
            .build()
    }

    @Singleton
    @Provides
    fun provideRetrofit(okHttpClient: OkHttpClient, BASE_URL: String): Retrofit = Retrofit.Builder()
        .baseUrl(BASE_URL)
        .addConverterFactory(GsonConverterFactory.create())
        .client(okHttpClient)
        .build()

    @Provides
    @Singleton
    fun provideApiService(retrofit: Retrofit): ApiService = retrofit.create(ApiService::class.java)

    @Provides
    @Singleton
    fun provideApiHelper(apiHelper: ApiHelperImpl): ApiHelper = apiHelper
}