package com.btgpactual.data.di

import com.btgpactual.data.local.database.CurrencyLayerDataBase
import com.btgpactual.data.local.source.CurrencyCacheDataSource
import com.btgpactual.data.local.source.CurrencyCacheDataSourceImpl
import org.koin.android.ext.koin.androidContext
import org.koin.dsl.module

val currencyCacheModule = module{
    single{ CurrencyLayerDataBase.createDatabase(androidContext()) }

    factory<CurrencyCacheDataSource> {
        CurrencyCacheDataSourceImpl(currencyCacheDao = get())
     }
}