package com.geocdias.convecurrency.di

import android.content.Context
import com.geocdias.convecurrency.data.database.CurrencyDatabase
import com.geocdias.convecurrency.data.database.dao.CurrencyDao
import com.geocdias.convecurrency.data.database.dao.ExchangeRateDao
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object DatabaseModule {

    @Singleton
    @Provides
    fun provideCurrencyDatabase(@ApplicationContext context: Context): CurrencyDatabase =
        CurrencyDatabase.getDatabase(context)

    @Singleton
    @Provides
    fun provideCurrencyDao(database: CurrencyDatabase): CurrencyDao = database.currencyDao()

    @Singleton
    @Provides
    fun provideExchangeRateDao(database: CurrencyDatabase): ExchangeRateDao = database.exchangeRateDao()
}
