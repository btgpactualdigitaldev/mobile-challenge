package br.com.btg.btgchallenge.di

import br.com.btg.btgchallenge.ui.fragments.conversions.ConversionViewModel
import br.com.btg.btgchallenge.ui.fragments.currencylist.CurrencyListViewModel
import org.koin.android.viewmodel.dsl.viewModel
import org.koin.dsl.module


val viewModelModule = module {
    viewModel {
        CurrencyListViewModel(get())
    }
    viewModel {
        ConversionViewModel(get())
    }
}
