package com.hotmail.fignunes.btg.repository.di

import com.hotmail.fignunes.btg.repository.Repository
import com.hotmail.fignunes.btg.repository.remote.Api
import com.hotmail.fignunes.btg.repository.remote.RemoteRepository
import com.hotmail.fignunes.btg.repository.remote.currencies.services.CurrenciesServices
import com.hotmail.fignunes.btg.repository.remote.quotedollar.services.QuoteDollarServices
import org.koin.android.ext.koin.androidApplication
import org.koin.dsl.module

object RepositoryModule {

    val repositoryModule = module {
        single { RemoteRepository() }
        single { Repository(androidApplication()) }

        single { Api<QuoteDollarServices>().create(QuoteDollarServices::class.java) }
        single { Api<CurrenciesServices>().create(CurrenciesServices::class.java) }
    }
}