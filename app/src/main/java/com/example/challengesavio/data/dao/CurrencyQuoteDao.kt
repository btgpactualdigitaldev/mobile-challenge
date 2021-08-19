package com.example.roomdatabase.dao

import androidx.room.*
import com.example.challengesavio.data.entity.Quote

@Dao
interface CurrencyQuoteDao {


    @Query("SELECT * FROM quote") fun getAllQuotes() : List<Quote>

    @Insert(onConflict = OnConflictStrategy.REPLACE) fun insertQuotes(vararg quotes: Quote)

}