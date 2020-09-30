package com.btgpactual.currencyconverter.data.repository

import com.btgpactual.currencyconverter.data.framework.roomdatabase.entity.CurrencyEntity
import com.btgpactual.currencyconverter.data.model.CurrencyModel

interface CurrencyInternalRepository {

    suspend fun insertAll(list:List<CurrencyModel>)

    suspend fun deleteAll()
    suspend fun getAll(): List<CurrencyModel>
    suspend fun getByCode(code:String): CurrencyModel?
    suspend fun getFirst(): CurrencyEntity
    suspend fun getCount(): Int

}