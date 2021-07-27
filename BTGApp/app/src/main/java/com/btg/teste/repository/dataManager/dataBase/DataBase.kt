package com.btg.teste.repository.dataManager.dataBase

import androidx.room.Database
import androidx.room.RoomDatabase
import com.btg.teste.repository.dataManager.dao.CurrenciesDAO
import com.btg.teste.repository.dataManager.entity.CurrenciesEntity

@Database(entities = arrayOf(
        CurrenciesEntity::class),
        version = 1,
    exportSchema = false)
abstract class DataBase : RoomDatabase() {

    companion object {
        val DATABASE_NAME = "BTGApp"
    }

    abstract fun currenciesDAO(): CurrenciesDAO
}