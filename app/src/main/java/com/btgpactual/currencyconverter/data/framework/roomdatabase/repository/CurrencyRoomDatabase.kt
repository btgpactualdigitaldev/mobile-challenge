package com.btgpactual.currencyconverter.data.framework.roomdatabase.repository

import com.btgpactual.currencyconverter.data.framework.roomdatabase.dao.CurrencyDAO
import com.btgpactual.currencyconverter.data.framework.roomdatabase.entity.*
import com.btgpactual.currencyconverter.data.model.CurrencyModel
import com.btgpactual.currencyconverter.data.repository.CurrencyInternalRepository

class CurrencyRoomDatabase(private val currencyDAO: CurrencyDAO) :
    CurrencyInternalRepository {

    override suspend fun insertAll(list: List<CurrencyModel>){
        list.forEach{
            currencyDAO.insert(it.toCurrencyEntity())
        }
    }

    override suspend fun deleteAll() {
        currencyDAO.deleteAll()
    }

    override suspend fun getByCode(code:String): CurrencyModel? {
        return  currencyDAO.getByCode("%$code%")?.toCurrencyModel()
    }

    override suspend fun getFirst(): CurrencyEntity {
        return currencyDAO.getFirst()
    }

    override suspend fun getAll(): List<CurrencyModel> {
        return currencyDAO.getAll().map { it.toCurrencyModel() }
    }

    override suspend fun getCount(): Int {
        return currencyDAO.getCount()
    }
}