package br.com.rcp.currencyconverter.database

import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import br.com.rcp.currencyconverter.database.dao.CurrencyDAO
import br.com.rcp.currencyconverter.database.entities.Currency

@Database(version = 1 , entities = [Currency::class], exportSchema = false)
abstract class CurrencyDB : RoomDatabase() {
    abstract fun currencyDAO() : CurrencyDAO
}