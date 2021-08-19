package br.dev.infra.btgconversiontool.network

import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory
import java.util.concurrent.TimeUnit

@InstallIn(SingletonComponent::class)
@Module
object CurrencyApiModule {

    //Base URL for API
    @Provides
    fun provideBaseUrl(): String = "https://btg-mobile-challenge.herokuapp.com"

    //Build Moshi JSON
    @Provides
    fun provideMoshi(): Moshi = Moshi.Builder()
        .add(KotlinJsonAdapterFactory())
        .build()

    //Add timeout
    @Provides
    fun okHttpClient(): OkHttpClient = OkHttpClient.Builder()
        .callTimeout(5, TimeUnit.SECONDS)
        .connectTimeout(5, TimeUnit.SECONDS)
        .readTimeout(10, TimeUnit.SECONDS)
        .build()

    //Build retrofit to get API data
    @Provides
    fun provideRetrofit(moshi: Moshi, BASE_URL: String, okHttpClient: OkHttpClient): Retrofit =
        Retrofit.Builder()
            .addConverterFactory(MoshiConverterFactory.create(moshi))
            .baseUrl(BASE_URL)
            .client(okHttpClient)
            .build()

    @Provides
    fun provideCurrencyApi(retrofit: Retrofit): CurrencyApiInterface =
        retrofit.create(CurrencyApiInterface::class.java)

    @Provides
    fun provideCurrencyHelper(currencyApiHelper: CurrencyApiHelperImpl): CurrencyApiHelper =
        currencyApiHelper

}