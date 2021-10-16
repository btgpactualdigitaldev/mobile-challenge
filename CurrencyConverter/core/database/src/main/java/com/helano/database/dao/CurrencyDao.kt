package com.helano.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.helano.shared.model.Currency

@Dao
interface CurrencyDao {

    @Query("SELECT * FROM currencies ORDER BY code")
    fun getAll(): List<Currency>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(data: List<Currency>)

    @Query("DELETE FROM currencies")
    fun deleteAll()

    @Query("SELECT * FROM currencies WHERE code = :code")
    fun getCurrency(code: String): Currency
}