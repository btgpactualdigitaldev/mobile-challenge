package com.btg.converter.presentation.di

import com.btg.converter.presentation.view.converter.ConverterViewModel
import com.btg.converter.presentation.view.currency.list.ListCurrenciesViewModel
import com.btg.converter.presentation.view.splash.SplashViewModel
import org.koin.android.viewmodel.dsl.viewModel
import org.koin.dsl.module

fun viewModelModule() = module {

    viewModel {
        ConverterViewModel(get(), get(), get())
    }

    viewModel {
        ListCurrenciesViewModel(get(), get())
    }

    viewModel { SplashViewModel() }
}