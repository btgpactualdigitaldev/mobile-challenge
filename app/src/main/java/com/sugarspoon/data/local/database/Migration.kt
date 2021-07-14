package com.sugarspoon.data.local.database

import android.content.Context
import androidx.room.Room
import androidx.room.migration.Migration
import androidx.sqlite.db.SupportSQLiteDatabase

class Migration(private val context: Context) {

    private fun getMigration(
        changes: String,
        from: Int,
        to: Int
    ) = object : Migration(from, to) {
        override fun migrate(database: SupportSQLiteDatabase) {
            database.execSQL("CREATE TABLE `btg_database` $changes")
        }
    }

    fun migrate(changes: String, from: Int, to: Int) {
        Room.databaseBuilder(
            context, BtgDataBase::class.java,
            "qr_database"
        ).addMigrations(
            getMigration(
                changes,
                from,
                to
            )
        ).build()
    }
}

