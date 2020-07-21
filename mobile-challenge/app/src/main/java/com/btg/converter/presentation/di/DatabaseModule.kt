package com.btg.converter.presentation.di

import com.btg.converter.data.local.ConverterDatabase
import org.koin.dsl.module

fun databaseModule() = module {
    single { ConverterDatabase.build(get()) }

    single {
        val converterDatabase = get() as ConverterDatabase
        converterDatabase.currencyDao()
    }

    single {
        val converterDatabase = get() as ConverterDatabase
        converterDatabase.quoteDao()
    }
}