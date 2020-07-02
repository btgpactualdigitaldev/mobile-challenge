package com.gui.antonio.testebtg.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.gui.antonio.testebtg.data.Currencies
import com.gui.antonio.testebtg.data.Quotes

@Database(entities = [Currencies::class, Quotes::class], version = 1, exportSchema = false)
abstract class AppDatabase : RoomDatabase() {
    abstract fun appDao(): AppDao
}