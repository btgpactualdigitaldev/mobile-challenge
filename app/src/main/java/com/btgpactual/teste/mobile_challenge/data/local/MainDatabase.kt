package com.btgpactual.teste.mobile_challenge.data.local

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.btgpactual.teste.mobile_challenge.R
import com.btgpactual.teste.mobile_challenge.data.local.dao.CurrencyDAO
import com.btgpactual.teste.mobile_challenge.data.local.dao.CurrencyValueDAO
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyEntity
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyValueEntity

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Database(
    entities = [
        CurrencyEntity::class,
        CurrencyValueEntity::class
    ],
    version = 1
)
abstract class MainDatabase: RoomDatabase() {

    abstract fun currencyDAO(): CurrencyDAO
    abstract fun currencyValueDAO(): CurrencyValueDAO

    companion object {

        @Volatile
        private var INSTANCE: MainDatabase? = null

        fun getInstance(context: Context): MainDatabase {
            val tempInstance = INSTANCE
            if (tempInstance != null) {
                return tempInstance
            }

            synchronized(MainDatabase::class) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    MainDatabase::class.java,
                    context.applicationContext.getString(R.string.database_name)
                ).build()

                INSTANCE = instance
                return instance
            }
        }
    }
}