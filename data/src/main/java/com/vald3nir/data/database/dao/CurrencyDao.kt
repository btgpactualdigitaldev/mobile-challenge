package com.vald3nir.data.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.vald3nir.data.database.model.Currency

@Dao
interface CurrencyDao {

    @Query("DELETE FROM currency")
    fun deleteAll()

    @Query("SELECT * FROM currency")
    fun getAll(): List<Currency>?

    @Query("SELECT * FROM currency WHERE code IN (:code)")
    fun loadById(code: String?): Currency?

    @Insert
    fun insertAll(currencies: List<Currency>?)
}