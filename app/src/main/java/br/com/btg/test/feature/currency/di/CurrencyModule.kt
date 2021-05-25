package br.com.btg.test.feature.currency.di

import androidx.room.Room
import br.com.btg.test.data.AppDatabase
import br.com.btg.test.data.DATABASE_NAME
import br.com.btg.test.feature.currency.api.ConvertAPI
import br.com.btg.test.feature.currency.business.ConvertUseCase
import br.com.btg.test.feature.currency.business.ListCurrenciesUseCase
import br.com.btg.test.feature.currency.repository.ConvertRepositoryImpl
import br.com.btg.test.feature.currency.repository.CurrencyRepository
import br.com.btg.test.feature.currency.viewmodel.CurrenciesListViewModel
import br.com.btg.test.feature.currency.viewmodel.CurrencyViewModel

import org.koin.android.ext.koin.androidContext
import org.koin.android.viewmodel.dsl.viewModel
import org.koin.dsl.module
import retrofit2.Retrofit

object CurrencyModule {
    val modules = module {
        // api
        factory { providerConvertAPI(get()) }

        // repository
        factory<CurrencyRepository> { ConvertRepositoryImpl(get()) }

        // business
        factory { ConvertUseCase(get()) }
        factory { ListCurrenciesUseCase(get(), get()) }

        // database
        single {
            Room.databaseBuilder(
                androidContext(),
                AppDatabase::class.java,
                DATABASE_NAME
            ).build()
        }
        single { get<AppDatabase>().currencyDao() }

        // viewmodels
        viewModel { CurrencyViewModel(get()) }
        viewModel { CurrenciesListViewModel(get()) }
    }

    private fun providerConvertAPI(retrofit: Retrofit) = retrofit.create(ConvertAPI::class.java)
}