package com.btgpactual.teste.mobile_challenge.data.local.datasource

import androidx.lifecycle.LiveData
import com.btgpactual.teste.mobile_challenge.data.local.dao.CurrencyDAO
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyEntity
import com.btgpactual.teste.mobile_challenge.data.local.repository.CurrencyRepository
import javax.inject.Inject

/**
 * Created by Carlos Souza on 16,October,2020
 */
class CurrencyDataSource @Inject constructor(private val currencyDAO: CurrencyDAO): CurrencyRepository {
    override suspend fun insert(data: CurrencyEntity): Long? {
        return currencyDAO.insert(data)
    }

    override suspend fun insertAll(data: List<CurrencyEntity>): List<Long>? {
        return currencyDAO.insertAll(data)
    }

    override suspend fun update(data: CurrencyEntity): Int? {
        return currencyDAO.update(data)
    }

    override suspend fun delete(data: CurrencyEntity) {
        return currencyDAO.delete(data)
    }

    override fun getAll(): LiveData<List<CurrencyEntity>>? {
        return currencyDAO.getAll()
    }

    override fun getById(id: String): CurrencyEntity? {
        return currencyDAO.getById(id)
    }
}