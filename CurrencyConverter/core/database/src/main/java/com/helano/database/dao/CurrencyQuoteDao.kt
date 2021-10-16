package com.helano.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.helano.shared.model.CurrencyQuote

@Dao
interface CurrencyQuoteDao {

    @Query("SELECT * FROM quotes ORDER BY code")
    fun getAll(): List<CurrencyQuote>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(data: List<CurrencyQuote>)

    @Query("DELETE FROM quotes")
    fun deleteAll()

    @Query("SELECT * FROM quotes WHERE code = :code")
    fun getCurrency(code: String): CurrencyQuote
}