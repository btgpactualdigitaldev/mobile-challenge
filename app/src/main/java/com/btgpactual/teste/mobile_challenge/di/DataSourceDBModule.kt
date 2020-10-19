package com.btgpactual.teste.mobile_challenge.di

import com.btgpactual.teste.mobile_challenge.data.local.datasource.CurrencyDataSource
import com.btgpactual.teste.mobile_challenge.data.local.datasource.CurrencyValueDataSource
import com.btgpactual.teste.mobile_challenge.data.local.repository.CurrencyRepository
import com.btgpactual.teste.mobile_challenge.data.local.repository.CurrencyValueRepository
import dagger.Binds
import dagger.Module

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Module
abstract class DataSourceDBModule {

    @Binds
    abstract fun providesCurrencyDataSource(currencyDataSource: CurrencyDataSource): CurrencyRepository

    @Binds
    abstract fun providesCurrencyValueDataSource(currencyValueDataSource: CurrencyValueDataSource): CurrencyValueRepository
}