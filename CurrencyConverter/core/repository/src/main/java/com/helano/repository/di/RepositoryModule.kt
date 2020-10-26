package com.helano.repository.di

import com.helano.repository.data.RemoteDataSource
import com.helano.repository.CurrencyRepository
import com.helano.repository.CurrencyRepositoryImpl
import com.helano.repository.data.LocalDataSource
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import javax.inject.Singleton

@Module
@InstallIn(ApplicationComponent::class)
object RepositoryModule {

    @Singleton
    @Provides
    fun provideRepository(local: LocalDataSource, remote: RemoteDataSource): CurrencyRepository {
        return CurrencyRepositoryImpl(local, remote)
    }
}