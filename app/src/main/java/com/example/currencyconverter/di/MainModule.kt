package com.example.currencyconverter.di

import androidx.room.Room
import com.example.currencyconverter.database.CurrencyDatabase
import com.example.currencyconverter.remote.createCurrencyListService
import com.example.currencyconverter.remote.createRateService
import com.example.currencyconverter.remote.getRetrofit
import com.example.currencyconverter.repository.ConverterRepository
import com.example.currencyconverter.repository.CurrencyListRepository
import com.example.currencyconverter.ui.converter.ConverterViewModel
import com.example.currencyconverter.ui.currencyList.CurrencyListViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val viewModelModule = module {
    viewModel {
        CurrencyListViewModel(get())
    }
    viewModel {
        ConverterViewModel(get())
    }
}

val networkModule = module {
    factory { createCurrencyListService(get()) }
    factory { createRateService(get()) }
    single { getRetrofit() }
}

val databaseModule = module {
    single { Room.databaseBuilder(get(), CurrencyDatabase::class.java, "currency").build() }
    single { get<CurrencyDatabase>().currencyDao() }
    single { ConverterRepository(get(), get(), get()) }
    single { CurrencyListRepository(get(), get(), get()) }
}





