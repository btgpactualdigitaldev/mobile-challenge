package com.desafio.btgpactual.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.desafio.btgpactual.database.dao.CurrencyDao
import com.desafio.btgpactual.database.dao.QuoteDao
import com.desafio.btgpactual.shared.constants.DATABASE_NAME
import com.desafio.btgpactual.shared.models.CurrencyModel
import com.desafio.btgpactual.shared.models.QuotesModel

@Database(entities = [CurrencyModel::class, QuotesModel::class], version = 1, exportSchema = false)
abstract class CoverterDatabase: RoomDatabase() {
    abstract fun getCurrencyDao(): CurrencyDao
    abstract fun getQuoteDao(): QuoteDao

    companion object {
        fun getInstance(context: Context): CoverterDatabase {
            return Room.databaseBuilder(
                context,
                CoverterDatabase::class.java,
                DATABASE_NAME
            ).build()
        }
    }

}