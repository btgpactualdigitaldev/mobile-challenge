package com.btg.convertercurrency.data_local.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.btg.convertercurrency.data_local.entity.CurrencyDb
import com.btg.convertercurrency.data_local.entity.QuoteDb

@Dao
interface QuoteDao {

    @Insert
    suspend fun insertAll(vararg quoteDb: QuoteDb)

    @Query("SELECT * FROM QuoteDb WHERE code =:code ORDER BY code")
    suspend fun getQuoteByCode(code:String): Array<QuoteDb>

    @Query("SELECT * FROM QuoteDb ORDER BY code")
    suspend fun getQuote(): Array<QuoteDb>

}