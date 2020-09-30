package com.btgpactual.currencyconverter.data.framework.roomdatabase.repository

import com.btgpactual.currencyconverter.data.framework.roomdatabase.dao.ConversionDAO
import com.btgpactual.currencyconverter.data.framework.roomdatabase.entity.ConversionEntity
import com.btgpactual.currencyconverter.data.repository.ConversionInternalRepository

class ConversionRoomDatabase(private val conversionDAO: ConversionDAO) :
    ConversionInternalRepository {

    override suspend fun insert(
        conversionEntity: ConversionEntity
    ): Long {
        return conversionDAO.insert(conversionEntity)
    }

    override suspend fun delete(id: Long) {
        conversionDAO.delete(id)
    }

    override suspend fun deleteAll() {
        conversionDAO.deleteAll()
    }

    override suspend fun getAll(): List<ConversionEntity> {
        return conversionDAO.getAll()
    }
}