package com.helano.database.di

import android.content.Context
import androidx.room.Room
import com.helano.database.AppDatabase
import com.helano.database.dao.CurrencyDao
import com.helano.database.dao.CurrencyQuoteDao
import com.helano.shared.Constants.DB_NAME
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Singleton

@Module
@InstallIn(ApplicationComponent::class)
object DatabaseModule {

    @Provides
    @Singleton
    fun provideDatabase(@ApplicationContext context: Context): AppDatabase {
        return Room.databaseBuilder(context, AppDatabase::class.java, DB_NAME)
            .fallbackToDestructiveMigration()
            .allowMainThreadQueries()
            .build()
    }

    @Provides
    @Singleton
    fun provideCurrencyDao(database: AppDatabase): CurrencyDao {
        return database.currencyDao()
    }

    @Provides
    @Singleton
    fun provideCurrencyQuoteDao(database: AppDatabase): CurrencyQuoteDao {
        return database.currencyQuoteDao()
    }
}