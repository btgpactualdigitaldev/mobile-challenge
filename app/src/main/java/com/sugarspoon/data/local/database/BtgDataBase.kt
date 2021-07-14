package com.sugarspoon.data.local.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.sugarspoon.data.local.dao.CurrencyDao
import com.sugarspoon.data.local.dao.QuotationDao
import com.sugarspoon.data.local.entity.CurrencyEntity
import com.sugarspoon.data.local.entity.QuotationEntity

@Database(
    entities = [CurrencyEntity::class, QuotationEntity::class],
    version = 1, exportSchema = false
)
abstract class BtgDataBase : RoomDatabase() {

    abstract fun currencyDao(): CurrencyDao
    abstract fun quotationDao(): QuotationDao

    companion object {
        @Volatile
        private var INSTANCE: BtgDataBase? = null

        fun getDatabase(
            context: Context
        ): BtgDataBase {
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    BtgDataBase::class.java,
                    "btg_database"
                ).build()
                INSTANCE = instance
                instance
            }
        }
    }
}