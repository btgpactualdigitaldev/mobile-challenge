package com.gft.presentation.di

import com.gft.data.api.CurrencyApi
import com.gft.data.datasource.CurrencyLocalDataSource
import com.gft.data.datasource.CurrencyLocalDataSourceImpl
import com.gft.data.datasource.CurrencyRemoteDataSource
import com.gft.data.datasource.CurrencyRemoteDataSourceImpl
import com.gft.data.repository.CurrencyRepositoryImpl
import com.gft.domain.repository.CurrencyRepository
import com.gft.domain.usecases.ConvertUseCase
import com.gft.domain.usecases.GetLabelsUseCase
import com.gft.presentation.viewmodel.ChooseCurrencyViewModel
import com.gft.presentation.viewmodel.CurrencyViewModel
import org.koin.android.viewmodel.ext.koin.viewModel
import org.koin.dsl.module.module
import retrofit2.Retrofit

val repositoryModule = module {
    single(name = DATA_SOURCE_REMOTE) { CurrencyRemoteDataSourceImpl(currencyApi = get(API)) as CurrencyRemoteDataSource }
    single(name = DATA_SOURCE_LOCAL) { CurrencyLocalDataSourceImpl() as CurrencyLocalDataSource }

    single(name = "CurrencyRepositoryImpl") {
        CurrencyRepositoryImpl(
            currencyRemoteDataSource = get(DATA_SOURCE_REMOTE),
            currencyLocalDataSource = get(DATA_SOURCE_LOCAL)
        ) as CurrencyRepository
    }
}

val useCasesModule = module {
    factory(name = GET_LABELS_USE_CASE) {
        GetLabelsUseCase(
            repository = get()
        )
    }
    factory(name = CONVERT_USE_CASE) {
        ConvertUseCase(
            repository = get()
        )
    }
}

val networkModule = module {
    single(name = RETROFIT_INSTANCE) { createNetworkClient(BASE_URL) }
    single(name = API) { (get(RETROFIT_INSTANCE) as Retrofit).create(CurrencyApi::class.java) }
}


val viewModelModule = module {
    viewModel {
        CurrencyViewModel(
            convertUseCase = get(CONVERT_USE_CASE)
        )
    }
    viewModel {
        ChooseCurrencyViewModel(
            getLabelsUseCase = get(GET_LABELS_USE_CASE)
        )
    }
}


private const val API = "API"
private const val DATA_SOURCE_REMOTE = "DATA_SOURCE_REMOTE"
private const val DATA_SOURCE_LOCAL = "DATA_SOURCE_LOCAL"

private const val GET_LABELS_USE_CASE = "GET_LABELS_USE_CASE"
private const val CONVERT_USE_CASE = "CONVERT_USE_CASE"

private const val BASE_URL = "http://api.currencylayer.com/"
private const val RETROFIT_INSTANCE = "RETROFIT"