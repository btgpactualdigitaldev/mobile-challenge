package br.net.easify.currencydroid.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import br.net.easify.currencydroid.database.model.Quote

@Dao
interface QuoteDao {
    @Query("SELECT * FROM quote ORDER BY id")
    fun getAll(): List<Quote>

    @Query("SELECT * FROM quote WHERE conversion LIKE :conversion")
    fun getQuote(conversion: String): Quote

    @Query("SELECT COUNT(*) FROM quote")
    fun getCount(): Long

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(quoteData: List<Quote>)

    @Query("DELETE FROM quote")
    fun deleteAll()
}