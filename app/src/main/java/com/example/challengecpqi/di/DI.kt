package com.example.challengecpqi.di

import androidx.navigation.NavController
import com.example.challengecpqi.network.config.ConnectivityInterceptor
import com.example.challengecpqi.network.config.ServiceConfig
import com.example.challengecpqi.repository.CurrencyRepository
import com.example.challengecpqi.repository.QuotesRepository
import com.example.challengecpqi.repository.SyncDownRepository
import com.example.challengecpqi.ui.conversion.ConversionViewModel
import com.example.challengecpqi.ui.listCurrency.ListCurrencyViewModel
import com.example.challengecpqi.ui.settings.SettingsViewModel
import org.koin.android.ext.koin.androidContext
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val coreModule = module {
    single {
        ConnectivityInterceptor(
            context = get()
        )
    }
    single {
        ServiceConfig(
            connectivityInterceptor = get()
        )
    }
}

val repositoryModule = module {
    factory { CurrencyRepository(context = androidContext(), service = get()) }
    factory { QuotesRepository(context = androidContext(), service = get()) }
    factory { SyncDownRepository(repCurrency = get(), repQuotes = get()) }
}

val viewModelModule = module {
    viewModel {
        ListCurrencyViewModel(repository = get())
    }

    viewModel {
        ConversionViewModel(repository = get())
    }

    viewModel { (navController: NavController) ->
        SettingsViewModel(repository = get(), navController = navController)
    }
}