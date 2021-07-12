package com.example.currencies.repository.local

import androidx.room.*
import com.example.currencies.model.room.CurrenciesModelLocal

@Dao
interface CurrenciesDAO {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun saveCurrencies(objects: CurrenciesModelLocal)

    @Query("SELECT * FROM Currencies")
    fun getAllCurrencies(): List<CurrenciesModelLocal>

    @Query("SELECT * FROM Currencies WHERE abbrev = :abbrev LIMIT 1")
    fun picCurrencies(abbrev: String): CurrenciesModelLocal

}