package com.romildosf.currencyconverter.dao

import androidx.room.*

@Dao
interface CurrencyDao {
    @Query("SELECT * FROM currency WHERE symbol = :symbol LIMIT 1")
    fun get(symbol: String): Currency

    @Query("SELECT * FROM currency")
    fun getAll(): List<Currency>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(currencies: List<Currency>)

    @Delete
    fun delete(currencies: List<Currency>)

    @Update
    fun update(currencies: List<Currency>)
}