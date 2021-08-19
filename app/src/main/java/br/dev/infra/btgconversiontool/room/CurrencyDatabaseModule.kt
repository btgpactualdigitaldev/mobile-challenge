package br.dev.infra.btgconversiontool.room

import android.content.Context
import androidx.room.Room
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

//Hilt Object Module creation for database
@InstallIn(SingletonComponent::class)
@Module
object CurrencyDatabaseModule {

    @Provides
    @Singleton
    fun provideCurrencyDatabase(
        @ApplicationContext app: Context
    ): CurrencyDatabase = Room.databaseBuilder(
        app.applicationContext,
        CurrencyDatabase::class.java,
        "currency_database"
    ).build()

    @Provides
    @Singleton
    fun provideCurrencyDatabaseDao(db: CurrencyDatabase) = db.currencyDatabaseDao()

}
