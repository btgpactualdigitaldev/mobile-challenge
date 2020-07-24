package com.desafio.btgpactual.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.desafio.btgpactual.shared.models.QuotesModel

@Dao
interface QuoteDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertQuotes(quotes: List<QuotesModel>)

    @Query("SELECT * FROM quotesModel")
    fun getAllQuotes(): List<QuotesModel>
}