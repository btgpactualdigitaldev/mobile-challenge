package com.br.cambio.di

import com.br.cambio.data.api.Api
import com.br.cambio.data.api.retrofit.HttpClient
import com.br.cambio.data.api.retrofit.RetrofitClient
import com.br.cambio.data.datasource.RemoteDataSource
import com.br.cambio.data.datasource.RemoteDataSourceImpl
import com.br.cambio.data.local.datasource.LocalDataSource
import com.br.cambio.data.local.datasource.LocalDataSourceImpl
import com.br.cambio.data.repository.CurrencyRepositoryImpl
import com.br.cambio.data.repository.PricesRepositoryImpl
import com.br.cambio.domain.repository.CurrencyRepository
import com.br.cambio.domain.repository.PricesRepository
import com.br.cambio.domain.usecase.GetCurrenciesUseCase
import com.br.cambio.domain.usecase.GetPricesUseCase
import com.br.cambio.presentation.viewmodel.MainViewModel
import kotlinx.coroutines.Dispatchers
import org.koin.android.ext.koin.androidContext
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

private const val BASE_URL = "https://btg-mobile-challenge.herokuapp.com"

val domainModules = module {
    factory { GetCurrenciesUseCase(repository = get()) }
    factory { GetPricesUseCase(repository = get()) }
}

val presentationModules = module {
    viewModel { MainViewModel(getCurrenciesUseCase = get(), getPricesUseCase = get(), dispatcher = Dispatchers.IO) }
}

val dataModules = module {
    factory<RemoteDataSource> { RemoteDataSourceImpl(service = get()) }
    factory<LocalDataSource> { LocalDataSourceImpl(local = get()) }
    factory<CurrencyRepository> { CurrencyRepositoryImpl(remoteDataSource = get(), localDataSource = get()) }
    factory<PricesRepository> { PricesRepositoryImpl(remoteDataSource = get(), localDataSource = get()) }
}

val anotherModules = module {
    single { RetrofitClient(application = androidContext(), BASE_URL).newInstance() }
    single { HttpClient(get()) }
    factory { get<HttpClient>().create(Api::class.java) }
}