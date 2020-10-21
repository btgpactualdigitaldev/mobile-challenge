package com.romildosf.currencyconverter.injection

import android.content.Context
import androidx.room.Room
import com.romildosf.currencyconverter.Constants
import com.romildosf.currencyconverter.dao.AppDatabase
import com.romildosf.currencyconverter.datasource.LocalCurrencyDataSource
import com.romildosf.currencyconverter.datasource.LocalCurrencyDataSourceImpl
import com.romildosf.currencyconverter.datasource.RemoteCurrencyDataSource
import com.romildosf.currencyconverter.datasource.RemoteCurrencyDataSourceImpl
import com.romildosf.currencyconverter.datasource.rest.ApiServiceFactory
import com.romildosf.currencyconverter.datasource.rest.CurrencyService
import com.romildosf.currencyconverter.repository.CurrencyRepository
import com.romildosf.currencyconverter.repository.CurrencyRepositoryImpl
import com.romildosf.currencyconverter.view.converter.CurrencyConverterViewModel
import com.romildosf.currencyconverter.view.list.CurrencyListViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.core.module.Module
import org.koin.dsl.module

class AppModule(appContext: Context) {
    private val db = Room.databaseBuilder(appContext, AppDatabase::class.java, "currency").build()

    private val dataSourceModule = module {
        val service = ApiServiceFactory().createService(CurrencyService::class.java, Constants.API_ENDPOINT)
        single<RemoteCurrencyDataSource> { RemoteCurrencyDataSourceImpl(service) }

        single<LocalCurrencyDataSource> { LocalCurrencyDataSourceImpl(db.currencyDao(), db.quotationDao()) }
    }

    private val repositoryModule = module {
        single<CurrencyRepository> { CurrencyRepositoryImpl(get(), get()) }
    }

    private val viewModelModule = module {
        viewModel { CurrencyListViewModel(get()) }
        viewModel { CurrencyConverterViewModel(get()) }
    }

    val subModules: List<Module>
        get() {
            return mutableListOf(
                repositoryModule,
                viewModelModule,
                dataSourceModule
            )
        }
}