package io.felipeandrade.currencylayertest.di

import io.felipeandrade.currencylayertest.ui.currency.conversion.CurrencyConversionViewModel
import io.felipeandrade.currencylayertest.ui.currency.selection.CurrencyListAdapter
import io.felipeandrade.currencylayertest.ui.currency.selection.CurrencySelectionViewModel
import io.felipeandrade.currencylayertest.usecase.ConvertUseCase
import io.felipeandrade.currencylayertest.usecase.LoadSupportedCurrenciesUseCase
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module


val currencyModule = module(override = true) {
    viewModel { CurrencyConversionViewModel(get()) }
    viewModel { CurrencySelectionViewModel(get()) }
    factory { CurrencyListAdapter() }

    single { LoadSupportedCurrenciesUseCase(get()) }
    single { ConvertUseCase(get()) }
}

