package com.btgpactual.mobilechallenge.di

import com.btgpactual.mobilechallenge.features.converter.ConverterViewModel
import com.btgpactual.mobilechallenge.features.listcurrencies.CurrenciesAdapter
import com.btgpactual.mobilechallenge.features.listcurrencies.CurrencyListViewModel
import io.reactivex.android.schedulers.AndroidSchedulers
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val currencyListModule = module{
    viewModel {
        CurrencyListViewModel(
            listUseCase = get(),
            uiScheduler = AndroidSchedulers.mainThread()
        )
    }

    factory {CurrenciesAdapter()}
}

val converterModule = module{
    viewModel {
        ConverterViewModel(
            converterUseCase = get(),
            uiScheduler = AndroidSchedulers.mainThread()
        )
    }
}



val presentationModule = currencyListModule + converterModule