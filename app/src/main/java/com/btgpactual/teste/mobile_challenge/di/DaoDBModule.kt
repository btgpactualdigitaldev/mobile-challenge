package com.btgpactual.teste.mobile_challenge.di

import com.btgpactual.teste.mobile_challenge.data.local.MainDatabase
import com.btgpactual.teste.mobile_challenge.data.local.dao.CurrencyDAO
import com.btgpactual.teste.mobile_challenge.data.local.dao.CurrencyValueDAO
import dagger.Module
import dagger.Provides
import javax.inject.Singleton

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Module
class DaoDBModule {

    @Singleton
    @Provides
    fun providesCurrencyDAO(mainDatabase: MainDatabase): CurrencyDAO {
        return mainDatabase.currencyDAO()
    }

    @Singleton
    @Provides
    fun providesCurrencyValueDAO(mainDatabase: MainDatabase): CurrencyValueDAO {
        return mainDatabase.currencyValueDAO()
    }
}