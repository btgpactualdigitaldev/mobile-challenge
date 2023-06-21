package com.btg.convertercurrency.data_local.dao

import androidx.room.*
import com.btg.convertercurrency.data_local.entity.CurrencyDb
import com.btg.convertercurrency.data_local.entity.CurrencyDbWithQuotiesDb
import java.time.OffsetDateTime

@Dao
interface CurrencyDao {

    @Insert
    suspend fun insertAll(vararg currencyDb: CurrencyDb): List<Long>

    @Query("SELECT * FROM CurrencyDb ORDER BY code")
    suspend fun getCurrency(): Array<CurrencyDb>

    @Transaction
    @Query("SELECT * FROM CurrencyDb ORDER BY code")
    suspend fun getCurrencyWithQuote(): Array<CurrencyDbWithQuotiesDb>


    //ORDER BY datetime()
    //https://medium.com/androiddevelopers/room-time-2b4cf9672b98
    @Transaction
    @Query("SELECT * FROM CurrencyDb WHERE code =:code ")
    suspend fun getCurrencyWithQuoteByCode(code: String): CurrencyDbWithQuotiesDb


    @Query("UPDATE CurrencyDb SET lastUpdate=:value ")
    suspend fun updateFieldLastUpdate(value: OffsetDateTime)

}