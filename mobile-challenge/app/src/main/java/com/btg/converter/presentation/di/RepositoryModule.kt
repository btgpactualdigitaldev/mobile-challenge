package com.btg.converter.presentation.di

import com.btg.converter.data.repository.DefaultCurrencyRepository
import com.btg.converter.data.repository.DefaultQuoteRepository
import com.btg.converter.domain.boundary.CurrencyRepository
import com.btg.converter.domain.boundary.QuoteRepository
import org.koin.dsl.module

fun repositoryModule() = module {
    single {
        DefaultCurrencyRepository(get(), get()) as CurrencyRepository
    }

    single {
        DefaultQuoteRepository(get(), get()) as QuoteRepository
    }
}