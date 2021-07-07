package br.com.leonamalmeida.mobilechallenge.di

import android.content.Context
import androidx.room.Room
import br.com.leonamalmeida.mobilechallenge.data.source.local.AppDatabase
import br.com.leonamalmeida.mobilechallenge.data.source.local.CurrencyLocalDataSource
import br.com.leonamalmeida.mobilechallenge.data.source.local.CurrencyLocalDataSourceImpl
import br.com.leonamalmeida.mobilechallenge.data.source.local.RateLocalDataSource
import br.com.leonamalmeida.mobilechallenge.data.source.local.RateLocalDataSourceImpl
import br.com.leonamalmeida.mobilechallenge.data.source.remote.CurrencyRemoteDataSource
import br.com.leonamalmeida.mobilechallenge.data.source.remote.CurrencyRemoteDataSourceImpl
import br.com.leonamalmeida.mobilechallenge.data.source.remote.RateRemoteDataSource
import br.com.leonamalmeida.mobilechallenge.data.source.remote.RateRemoteDataSourceImpl
import br.com.leonamalmeida.mobilechallenge.data.repositories.CurrencyRepository
import br.com.leonamalmeida.mobilechallenge.data.repositories.CurrencyRepositoryImpl
import br.com.leonamalmeida.mobilechallenge.data.repositories.RateRepository
import br.com.leonamalmeida.mobilechallenge.data.repositories.RateRepositoryImpl
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Singleton

/**
 * Created by Leo Almeida on 27/06/20.
 */
@Module
@InstallIn(ApplicationComponent::class)
object AppModule {

    @Singleton
    @Provides
    fun provideCurrencyRemoteDataSource(): CurrencyRemoteDataSource {
        return CurrencyRemoteDataSourceImpl(
            NetworkModule.provideCurrencyService()
        )
    }

    @Singleton
    @Provides
    fun provideCurrencyLocalDataSource(database: AppDatabase): CurrencyLocalDataSource {
        return CurrencyLocalDataSourceImpl(
            database.currencyDao()
        )
    }

    @Singleton
    @Provides
    fun provideRateRemoteDataSource(): RateRemoteDataSource {
        return RateRemoteDataSourceImpl(
            NetworkModule.provideCurrencyService()
        )
    }

    @Singleton
    @Provides
    fun provideRateLocalDataSource(database: AppDatabase): RateLocalDataSource {
        return RateLocalDataSourceImpl(
            database.rateDao()
        )
    }

    @Singleton
    @Provides
    fun provideDataBase(@ApplicationContext context: Context): AppDatabase {
        return Room.databaseBuilder(
            context.applicationContext,
            AppDatabase::class.java,
            "AppDatabase.db"
        ).build()
    }
}

@Module
@InstallIn(ApplicationComponent::class)
object CurrencyRepositoryModule {

    @Singleton
    @Provides
    fun provideCurrencyRepository(
        currencyRemoteDataSource: CurrencyRemoteDataSource,
        currencyLocalDataSource: CurrencyLocalDataSource
    ): CurrencyRepository =
        CurrencyRepositoryImpl(
            currencyRemoteDataSource,
            currencyLocalDataSource
        )
}

@Module
@InstallIn(ApplicationComponent::class)
object RateRepositoryModule {

    @Singleton
    @Provides
    fun provideRateRepository(
        rateRemoteDataSource: RateRemoteDataSource,
        rateLocalDataSource: RateLocalDataSource
    ): RateRepository =
        RateRepositoryImpl(
            rateRemoteDataSource,
            rateLocalDataSource
        )
}
