package com.example.desafiobtg.di

import com.example.desafiobtg.ui.convert.ConvertViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val viewModelModule = module {
    viewModel { ConvertViewModel(repository = get()) }
}