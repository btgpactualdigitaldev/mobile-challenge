package com.gui.antonio.testebtg.database

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.gui.antonio.testebtg.data.Currencies
import com.gui.antonio.testebtg.data.Quotes

@Dao
interface AppDao {

    @Query("SELECT * FROM currencies")
    fun getCurrencies(): List<Currencies>

    @Insert
    fun insertCurrencies(currenciesData: List<Currencies>)

    @Query("DELETE FROM currencies")
    fun deleteCurrencies()

    @Query("SELECT * FROM quotes")
    fun getQuotes(): List<Quotes>

    @Query("SELECT * FROM quotes WHERE symbol = :symbol ")
    fun getQuote(symbol: String):Quotes

    @Insert
    fun insertQuotes(quotes: List<Quotes>)

    @Query("DELETE FROM quotes")
    fun deleteQuotes()

}