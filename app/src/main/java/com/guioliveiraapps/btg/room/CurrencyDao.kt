package com.guioliveiraapps.btg.room

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface CurrencyDao {
    @Query("SELECT * FROM currency")
    fun getAll(): List<Currency>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(quotes: List<Currency>)

    @Query("DELETE FROM currency")
    fun deleteAll()
}