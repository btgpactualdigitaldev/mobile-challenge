package com.btg.convertercurrency.features.home.di

import com.btg.convertercurrency.features.home.view.HomeViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val homeModule = module {

    viewModel { HomeViewModel(get())}
}