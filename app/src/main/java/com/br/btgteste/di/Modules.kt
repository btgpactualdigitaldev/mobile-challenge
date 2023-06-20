package com.br.btgteste.di

import com.br.btgteste.data.local.DatabaseConfiguration
import com.br.btgteste.data.local.datasource.CurrencyDataSourceImp
import com.br.btgteste.data.remote.RetrofitConfiguration
import com.br.btgteste.data.repositories.CurrenciesRepositoryImpl
import com.br.btgteste.domain.datasource.CurrencyDataSource
import com.br.btgteste.domain.repository.CurrenciesRepository
import com.br.btgteste.domain.usecase.CurrencyListUseCase
import com.br.btgteste.domain.usecase.CurrencyLiveUseCase
import com.br.btgteste.presentation.convert.ConvertCurrencyViewModel
import com.br.btgteste.presentation.list.ListCurrencyViewModel
import org.koin.android.ext.koin.androidContext
import org.koin.android.viewmodel.ext.koin.viewModel
import org.koin.dsl.module.module

val listModules = listOf(
    module {

        single { RetrofitConfiguration().getAppRequest() }
        single { DatabaseConfiguration().createDatabase(androidContext()) }

        factory<CurrenciesRepository> { CurrenciesRepositoryImpl(get()) }
        factory<CurrencyDataSource> { CurrencyDataSourceImp(get()) }

        single { CurrencyListUseCase(get(), get()) }
        single { CurrencyLiveUseCase(get()) }

        viewModel { ConvertCurrencyViewModel(get()) }
        viewModel { ListCurrencyViewModel(get()) }
    }
)