package com.btgpactual.data.di

import com.btgpactual.data.BuildConfig
import com.btgpactual.data.repository.CurrenciesRepositoryImpl
import com.btgpactual.domain.repository.CurrenciesRepository
import org.koin.dsl.module


val repositoryModule = module{
    factory<CurrenciesRepository>{
        CurrenciesRepositoryImpl(
            apiKey = BuildConfig.API_KEY,
            listRemoteDataSource = get(),
            liveRemoteDataSource = get(),
            currencyCacheDataSource = get()
        )
    }
}

val dataModules = listOf(currencyCacheModule, remoteDataSourceModule, repositoryModule)