package com.vald3nir.data.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.vald3nir.data.database.model.Exchange

@Dao
interface ExchangeDao {

    @Query("DELETE FROM exchange")
    fun deleteAll()

    @Query("SELECT * FROM exchange")
    fun getAll(): List<Exchange>?

    @Query("SELECT * FROM exchange WHERE quote IN (:quote)")
    fun loadByQuote(quote: String?): Exchange?

    @Insert
    fun insertAll(exchanges: List<Exchange>?)

}