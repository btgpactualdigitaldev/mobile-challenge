package com.btg.convertercurrency.features.currency_converter.di

import com.btg.convertercurrency.data_local.RepositoryCurrencyLayerLocal
import com.btg.convertercurrency.data_local.RepositorySettingsLocal
import com.btg.convertercurrency.data_local.database.AppDatabase
import com.btg.convertercurrency.data_network.repository.RepositoryCurrencyLayerNetwork
import com.btg.convertercurrency.features.currency_converter.view.CurrencyConverterViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val currencyConverterModule = module {


    single { RepositorySettingsLocal(AppDatabase.getInstance(get())) }
    single { RepositoryCurrencyLayerLocal(AppDatabase.getInstance(get())) }
    single { RepositoryCurrencyLayerNetwork(get()) }


    viewModel { CurrencyConverterViewModel(get(), get(), get(), get()) }
}