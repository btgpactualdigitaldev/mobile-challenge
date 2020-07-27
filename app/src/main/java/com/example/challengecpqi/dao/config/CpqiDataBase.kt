package com.example.challengecpqi.dao.config

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.example.challengecpqi.dao.CurrencyDao
import com.example.challengecpqi.dao.CurrencyResponseDao
import com.example.challengecpqi.dao.QuoteDao
import com.example.challengecpqi.dao.QuoteResponseDao
import com.example.challengecpqi.dao.entiry.CurrencyEntity
import com.example.challengecpqi.dao.entiry.CurrencyResponseEntity
import com.example.challengecpqi.dao.entiry.QuoteEntity
import com.example.challengecpqi.dao.entiry.QuoteResponseEntity

@Database(entities = [CurrencyResponseEntity::class,
    CurrencyEntity::class,
    QuoteResponseEntity::class,
    QuoteEntity::class],
    version = 1)
abstract class CpqiDataBase : RoomDatabase() {

    abstract fun currencyResponseDao(): CurrencyResponseDao
    abstract fun currencyDao() : CurrencyDao
    abstract fun quoteResponseDao() : QuoteResponseDao
    abstract fun quoteDao() : QuoteDao

    companion object {
        @Volatile
        private var INSTANCE: CpqiDataBase? = null
        fun invoke(context: Context) : CpqiDataBase {

            val tempInstance = INSTANCE
            if (tempInstance != null) {
                return tempInstance
            }
            synchronized(this) {
                val instance =  Room.databaseBuilder(context.applicationContext,
                    CpqiDataBase::class.java,
                    "cpqiDataBase.db")
                    .build()
                INSTANCE = instance
                return instance
            }
        }
    }

}