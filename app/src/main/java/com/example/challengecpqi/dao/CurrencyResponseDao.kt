package com.example.challengecpqi.dao

import androidx.room.Dao
import androidx.room.Query
import androidx.room.Transaction
import com.example.challengecpqi.dao.entiry.CurrencyResponseEntity
import com.example.challengecpqi.dao.entiry.CurrencyResponseWithCurrency

@Dao
interface CurrencyResponseDao: GenericDao<CurrencyResponseEntity> {

    @Transaction
    @Query("SELECT * FROM CurrencyResponseEntity")
    suspend fun allCurrencyResponse(): CurrencyResponseWithCurrency?

    @Query("SELECT * FROM CurrencyResponseEntity")
    suspend fun getCurrencyResponse(): CurrencyResponseEntity?
}