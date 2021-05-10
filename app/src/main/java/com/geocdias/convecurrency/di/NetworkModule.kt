package com.geocdias.convecurrency.di

import com.geocdias.convecurrency.data.network.CurrencyApi
import com.geocdias.convecurrency.data.network.CurrencyClient
import com.geocdias.convecurrency.util.Constants
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {

    @Singleton
    @Provides
    fun provideCurrencyApi(): CurrencyApi = Retrofit.Builder()
        .baseUrl(Constants.BASE_URL)
        .addConverterFactory(GsonConverterFactory.create())
        .build()
        .create(CurrencyApi::class.java)

    @Provides
    @Singleton
    fun provideCurrencyClient(currencyApi: CurrencyApi): CurrencyClient =
        CurrencyClient(currencyApi)
}
