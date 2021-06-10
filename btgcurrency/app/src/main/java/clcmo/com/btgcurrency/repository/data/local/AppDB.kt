package clcmo.com.btgcurrency.repository.data.local

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import clcmo.com.btgcurrency.repository.data.local.entity.CEntity
import clcmo.com.btgcurrency.repository.data.local.entity.QEntity
import clcmo.com.btgcurrency.util.constants.Constants.DB_NAME

@Database(entities = [CEntity::class, QEntity::class], version = 1, exportSchema = false)
abstract class AppDB : RoomDatabase() {


    abstract fun currencyDao(): CDao
    abstract fun currencyQuoteDao(): QDao

    companion object {
        fun createDB(context: Context) = Room
            .databaseBuilder(context, AppDB::class.java, DB_NAME).build()
    }
}