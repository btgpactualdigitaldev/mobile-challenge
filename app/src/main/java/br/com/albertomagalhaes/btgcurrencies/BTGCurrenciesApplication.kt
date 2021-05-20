package br.com.albertomagalhaes.btgcurrencies

import android.app.Application
import br.com.albertomagalhaes.btgcurrencies.api.NetworkInterceptor
import br.com.albertomagalhaes.btgcurrencies.database.AppDatabase
import br.com.albertomagalhaes.btgcurrencies.repository.CurrencyRepository
import br.com.albertomagalhaes.btgcurrencies.repository.CurrencyRepositoryImpl
import br.com.albertomagalhaes.btgcurrencies.viewmodel.MainViewModel
import br.com.albertomagalhaes.btgcurrencies.viewmodel.SetupViewModel
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.core.context.startKoin
import org.koin.dsl.module

class BTGCurrenciesApplication : Application() {
    override fun onCreate() {
        super.onCreate()

        val appModule = module {
            single {
                NetworkInterceptor(
                    this@BTGCurrenciesApplication
                )
            }
            single { AppDatabase.getInstance(this@BTGCurrenciesApplication).currencyDAO }
            single<CurrencyRepository> {
                CurrencyRepositoryImpl(
                    get(),
                    get()
                )
            }

            viewModel {
                MainViewModel(
                    get()
                )
            }
            viewModel {
                SetupViewModel(
                    get()
                )
            }
        }

        startKoin {
            androidLogger()
            androidContext(this@BTGCurrenciesApplication)
            modules(appModule)
        }
    }
}