package com.geocdias.convecurrency.data.database.dao

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.geocdias.convecurrency.data.database.entities.CurrencyEntity

@Dao
interface CurrencyDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertCurrencyList(currencies: List<CurrencyEntity>)

    @Query("SELECT * FROM currency ORDER BY code ASC")
    fun observeCurrencyList():LiveData<List<CurrencyEntity>>

    @Query("SELECT * FROM currency WHERE code = :code")
    fun getCurrencyByCode(code: String):LiveData<CurrencyEntity>

    @Query("SELECT * FROM currency WHERE name LIKE '%' || :name || '%'")
    fun getCurrencyByName(name: String):LiveData<List<CurrencyEntity>>

    @Query("SELECT code FROM currency")
    fun getAllCurrencyCodes():LiveData<List<String>>
}
