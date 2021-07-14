package com.sugarspoon.data.local.dao

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Query
import com.sugarspoon.data.local.entity.CurrencyEntity
import com.sugarspoon.data.local.entity.QuotationEntity
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow

@Dao
interface QuotationDao {
    @Query("SELECT * FROM quotation_table")
    fun getAll(): Flow<List<QuotationEntity>>

    @Query("SELECT * FROM quotation_table WHERE id IN (:userIds)")
    fun getAllByIds(userIds: IntArray): Flow<List<QuotationEntity>>

    @Insert
    fun insertAll(quotation: QuotationEntity)

    @Query("DELETE FROM quotation_table")
    fun delete()

    @Query("SELECT * FROM quotation_table WHERE code = :code")
    fun findQuotationByCode(code: String): Flow<QuotationEntity>
}

