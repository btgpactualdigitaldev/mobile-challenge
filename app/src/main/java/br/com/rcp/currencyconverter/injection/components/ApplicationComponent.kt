package br.com.rcp.currencyconverter.injection.components

import android.content.Context
import br.com.rcp.currencyconverter.database.CurrencyDB
import br.com.rcp.currencyconverter.injection.modules.DatabaseModule
import br.com.rcp.currencyconverter.injection.modules.RepositoryModule
import br.com.rcp.currencyconverter.injection.modules.RetrofitModule
import br.com.rcp.currencyconverter.repository.CurrenciesRepository
import br.com.rcp.currencyconverter.utils.APIService
import dagger.BindsInstance
import dagger.Component
import javax.inject.Singleton

@Singleton
@Component(modules = [RetrofitModule::class, DatabaseModule::class, RepositoryModule::class])
interface ApplicationComponent {
    fun getServiceAPI()             : APIService
    fun getCurrenciesDatabase()     : CurrencyDB
    fun getCurrenciesRepository()   : CurrenciesRepository


    @Component.Factory
    interface Factory {
        fun create(@BindsInstance context: Context): ApplicationComponent
    }
}