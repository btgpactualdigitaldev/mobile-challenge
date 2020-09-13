package br.com.rcp.currencyconverter.injection.modules

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import br.com.rcp.currencyconverter.database.CurrencyDB
import dagger.Module
import dagger.Provides
import javax.inject.Singleton

@Module
object DatabaseModule {
    @Singleton
    @Provides
    fun provideDatabaseInstance(context: Context): CurrencyDB {
        return Room.databaseBuilder(context, CurrencyDB::class.java, "database").fallbackToDestructiveMigration().build()
    }
}