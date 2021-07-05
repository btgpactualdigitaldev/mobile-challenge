package com.example.currencyconverter.database

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface CurrencyDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertRates(currencies: List<CurrencyModel>)

    @Query("SELECT * FROM currency")
    suspend fun getAll(): List<CurrencyModel>

}