package com.btgpactual.data.local.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.btgpactual.data.local.model.CurrencyCache

@Database(version = 1, entities = [CurrencyCache::class])
abstract class CurrencyLayerDataBase : RoomDatabase() {
    abstract fun currencyCacheDao() : CurrencyCacheDao

    companion object{
        fun createDatabase(context: Context) : CurrencyCacheDao{
            return Room
                .databaseBuilder(context,CurrencyLayerDataBase::class.java,"CurrencyLayer.db")
                .build()
                .currencyCacheDao()
        }
    }
}