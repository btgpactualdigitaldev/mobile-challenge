package com.example.currencies.repository.local

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.example.currencies.model.room.RatesModelLocal

@Dao
interface RatesDAO {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun saveRates(objects: RatesModelLocal)

    @Query("SELECT * FROM Rates")
    fun getAllRates(): List<RatesModelLocal>

    @Query("SELECT * FROM Rates WHERE abbrev = :abbrev LIMIT 1")
    fun picRates(abbrev: String): RatesModelLocal

}