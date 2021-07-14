package com.sugarspoon.data.local.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.sugarspoon.data.local.entity.CurrencyEntity
import kotlinx.coroutines.flow.Flow

@Dao
interface CurrencyDao {
    @Query("SELECT * FROM currency_table")
    fun getAll(): Flow<List<CurrencyEntity>>

    @Query("SELECT * FROM currency_table WHERE id IN (:userIds)")
    fun getAllByIds(userIds: IntArray): Flow<List<CurrencyEntity>>

    @Insert
    fun insertAll(currency: CurrencyEntity)

    @Query("DELETE FROM currency_table")
    fun delete()

    @Query("SELECT * FROM currency_table WHERE id = :name")
    fun getCurrencyByName(name: String): CurrencyEntity
}

