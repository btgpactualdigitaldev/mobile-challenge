package br.net.easify.currencydroid.di.module

import android.app.Application
import br.net.easify.currencydroid.api.CurrencyService
import br.net.easify.currencydroid.api.QuoteService
import br.net.easify.currencydroid.database.AppDatabase
import br.net.easify.currencydroid.util.ServiceUtil
import br.net.easify.currencydroid.util.SharedPreferencesUtil
import dagger.Module
import dagger.Provides
import javax.inject.Singleton

@Module
class AppModule(private var application: Application) {

    @Provides
    @Singleton
    fun providesApplication(): Application {
        return application
    }

    @Provides
    @Singleton
    fun providesAppDatabase(application: Application): AppDatabase {
        return AppDatabase.getAppDataBase(application)
    }

    @Provides
    fun providesCurrencyService(): CurrencyService {
        return CurrencyService()
    }

    @Provides
    fun providesQuoteService(): QuoteService {
        return QuoteService()
    }

    @Provides
    @Singleton
    fun providesServiceUtil(application: Application): ServiceUtil {
        return ServiceUtil(application)
    }

    @Provides
    @Singleton
    fun provideSharedPreferences(application: Application): SharedPreferencesUtil {
        return SharedPreferencesUtil(application)
    }
}