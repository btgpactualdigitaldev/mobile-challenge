package com.guioliveiraapps.btg.room

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface QuoteDao {
    @Query("SELECT * FROM quote")
    fun getAll(): List<Quote>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(quotes: List<Quote>)

    @Query("DELETE FROM quote")
    fun deleteAll()
}