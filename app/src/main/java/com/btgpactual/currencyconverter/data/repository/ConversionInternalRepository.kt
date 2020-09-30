package com.btgpactual.currencyconverter.data.repository

import com.btgpactual.currencyconverter.data.framework.roomdatabase.entity.ConversionEntity

interface ConversionInternalRepository {
    suspend fun insert(conversionEntity: ConversionEntity): Long

    suspend fun delete(id: Long)

    suspend fun deleteAll()

    suspend fun getAll(): List<ConversionEntity>
}