package com.example.challengecpqi.dao

import androidx.room.Dao
import androidx.room.Query
import androidx.room.Transaction
import com.example.challengecpqi.dao.entiry.QuoteResponseEntity
import com.example.challengecpqi.dao.entiry.QuoteResponseWithQuote

@Dao
interface QuoteResponseDao: GenericDao<QuoteResponseEntity> {

    @Transaction
    @Query("SELECT * FROM QuoteResponseEntity")
    suspend fun allQuoteResponse(): QuoteResponseWithQuote?

    @Query("SELECT * FROM QuoteResponseEntity")
    suspend fun getQuoteResponse(): QuoteResponseEntity?
}