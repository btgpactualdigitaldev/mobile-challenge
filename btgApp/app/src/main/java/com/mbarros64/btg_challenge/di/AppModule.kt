package com.mbarros64.btg_challenge.di

import androidx.room.Room
import com.mbarros64.btg_challenge.database.AppDatabase
import com.mbarros64.btg_challenge.network.provideCurrencyListService
import com.mbarros64.btg_challenge.network.provideCurrencyLiveService
import com.mbarros64.btg_challenge.network.provideRetrofit
import com.mbarros64.btg_challenge.repository.HomeRepository
import com.mbarros64.btg_challenge.repository.ListRepository
import com.mbarros64.btg_challenge.ui.fragment.currencyList.CurrencyListViewModel
import com.mbarros64.btg_challenge.ui.fragment.home.HomeViewModel
import org.koin.android.viewmodel.dsl.viewModel
import org.koin.dsl.module

val networkModule = module {
    factory { provideCurrencyLiveService(get()) }
    factory { provideCurrencyListService(get()) }
    single { provideRetrofit() }
}

val databaseModule = module {
    single {
        Room.databaseBuilder(
                get(),
                AppDatabase::class.java,
                //BuildConfig.DATABASE_NAME
                "currency-database"
        ).build()
    }
}

val resourceModule = module {
    single { get<AppDatabase>().currencyDao() }

    single { ListRepository(get()) }

    single { HomeRepository(get(), get(), get()) }
}

val viewModelModule = module {
    viewModel {
        HomeViewModel(get())
    }
    viewModel {
        CurrencyListViewModel(get())
    }
}

