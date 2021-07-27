package com.lucasnav.desafiobtg.modules.currencyConverter.database

import androidx.room.*
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Quote
import io.reactivex.Observable

@Dao
interface QuotesDao {
    @Query("SELECT * FROM quotes")
    fun getQuotes(): Observable<List<Quote>>

    @Transaction
    fun deleteAndInsert(quotes: List<Quote>) {
        deleteQuotes()
        insertAll(quotes)
    }

    @Query("DELETE FROM quotes")
    fun deleteQuotes()

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(quotes: List<Quote>)

    @Query("SELECT * FROM quotes WHERE symbol=:symbol2 OR symbol=:symbol1")
    fun getTwoQuotes(symbol1: String, symbol2: String): Observable<List<Quote>>
}