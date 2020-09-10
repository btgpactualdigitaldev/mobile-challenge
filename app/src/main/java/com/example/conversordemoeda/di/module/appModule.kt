package com.example.conversordemoeda.di.module

import com.example.conversordemoeda.model.repositorio.MoedaRepository
import com.example.conversordemoeda.model.repositorio.MoedaRepositoryImp
import com.example.conversordemoeda.model.retrofit.RetrofitConfig
import com.example.conversordemoeda.viewmodel.ListaDeMoedasViewModel
import com.example.conversordemoeda.viewmodel.MainViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

const val PROPERTY_BASE_URL = "PROPERTY_BASE_URL"

val appModule = module {

    factory{
        val baseUrl = getProperty(PROPERTY_BASE_URL)
        RetrofitConfig(baseUrl)
    }

    single {
        MoedaRepositoryImp(retrofitConfig = get())
    }

    viewModel {
        MainViewModel(get<MoedaRepositoryImp>() as MoedaRepository)
    }

    viewModel {
        ListaDeMoedasViewModel(get<MoedaRepositoryImp>() as MoedaRepository)
    }
}