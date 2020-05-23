package com.btg.converter.presentation.di

import com.btg.converter.domain.interactor.GetCurrencyList
import com.btg.converter.domain.interactor.GetCurrentQuotes
import org.koin.dsl.module

fun interactorModule() = module{
    single{
        GetCurrencyList(get())
    }

    single{
        GetCurrentQuotes(get())
    }
}