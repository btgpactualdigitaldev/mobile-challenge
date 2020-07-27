package com.example.challengecpqi.dao

import androidx.room.Dao
import androidx.room.Query
import com.example.challengecpqi.dao.entiry.CurrencyEntity
import com.example.challengecpqi.dao.entiry.QuoteEntity

@Dao
interface QuoteDao: GenericDao<QuoteEntity> {

    @Query("SELECT * FROM QuoteEntity")
    suspend fun getQuote() : List<QuoteEntity>
}