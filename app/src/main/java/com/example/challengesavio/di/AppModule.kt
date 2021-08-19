package com.example.challengesavio.di
import com.example.challengesavio.api.repositories.MainRepository
import com.example.challengesavio.api.services.RetrofitService
import com.example.challengesavio.viewmodels.CurrenciesViewModel
import org.koin.android.viewmodel.dsl.viewModel
import org.koin.dsl.module

var viewModelModule = module {
    viewModel { CurrenciesViewModel(get()) }
}

val repository = module {
    //Repository
    single { MainRepository(get()) }
}

val networkModule = module {
    single { RetrofitService.getInstance() }
}
