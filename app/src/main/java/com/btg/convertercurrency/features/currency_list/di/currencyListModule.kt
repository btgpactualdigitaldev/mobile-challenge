package com.btg.convertercurrency.features.currency_list.di

import com.btg.convertercurrency.features.currency_list.view.ListCurrencyViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val listCurrencyModule = module {

    viewModel { ListCurrencyViewModel(get(),get()) }
}