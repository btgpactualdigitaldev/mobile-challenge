package br.com.rcp.currencyconverter.injection.modules

import br.com.rcp.currencyconverter.repository.CurrenciesRepository
import dagger.Module
import dagger.Provides
import dagger.Reusable
import javax.inject.Singleton

@Module
object RepositoryModule {
    @Singleton @Provides fun getCurrenciesRepository() = CurrenciesRepository()
}