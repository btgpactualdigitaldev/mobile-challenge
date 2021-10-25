package com.leonardocruz.btgteste.di

import com.leonardocruz.btgteste.ui.currencyList.viewmodel.BtgViewModel
import com.leonardocruz.btgteste.repository.CurrencyRepository
import org.koin.android.viewmodel.dsl.viewModel
import org.koin.dsl.module

val viewModelModule = module {
    viewModel { (repository : CurrencyRepository) -> BtgViewModel(repository) }
}