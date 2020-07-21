package com.btg.converter.data.local.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.btg.converter.data.local.entity.DbQuote

@Dao
interface QuoteDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertQuotes(quotes: List<DbQuote>)

    @Query("SELECT * FROM quote")
    suspend fun getQuotes(): List<DbQuote>
}