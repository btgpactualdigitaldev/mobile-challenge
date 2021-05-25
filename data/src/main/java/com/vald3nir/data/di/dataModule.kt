package com.vald3nir.data.di

import com.vald3nir.data.database.DatabaseHandler
import com.vald3nir.data.repository.DataRepository
import com.vald3nir.data.rest.RestClient
import org.koin.android.ext.koin.androidContext
import org.koin.dsl.module

val dataModule = module {

    single { DatabaseHandler(context = androidContext()) }

    single { RestClient() }

    factory {
        DataRepository(database = get(), restClient = get())
    }

}