package com.example.challengecpqi.dao

import androidx.room.Dao
import androidx.room.Query
import com.example.challengecpqi.dao.entiry.CurrencyEntity

@Dao
interface CurrencyDao: GenericDao<CurrencyEntity> {

    @Query("SELECT * FROM CurrencyEntity")
    suspend fun getCurrency() : List<CurrencyEntity>

    @Query("SELECT * FROM CurrencyEntity WHERE `key` LIKE :value OR value LIKE :value")
    suspend fun getCurrency(value: String) : List<CurrencyEntity>

}