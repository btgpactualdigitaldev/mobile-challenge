package com.vald3nir.btg_challenge.core.di

import com.vald3nir.btg_challenge.ui.currencies.CurrenciesViewModel
import com.vald3nir.btg_challenge.ui.home.HomeViewModel
import com.vald3nir.btg_challenge.ui.splash.FullscreenViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val appModule = module {

    viewModel {
        FullscreenViewModel(dataRepository = get())
    }

    viewModel {
        HomeViewModel(dataRepository = get())
    }

    viewModel {
        CurrenciesViewModel(dataRepository = get())
    }
}