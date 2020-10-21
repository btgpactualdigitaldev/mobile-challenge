package com.romildosf.currencyconverter.dao

import androidx.room.*

@Dao
interface QuotationDao {
    @Query("SELECT * FROM quotation")
    fun getAll(): List<Quotation>

    @Query("SELECT * FROM quotation WHERE pair = :pair LIMIT 1")
    fun get(pair: String): Quotation

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(quotes: List<Quotation>)

    @Update
    fun update(quotes: List<Quotation>)

    @Delete
    fun delete(quotes: List<Quotation>)
}