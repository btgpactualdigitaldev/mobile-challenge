package com.btgpactual.teste.mobile_challenge.data.local.datasource

import androidx.lifecycle.LiveData
import com.btgpactual.teste.mobile_challenge.data.local.dao.CurrencyValueDAO
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyValueEntity
import com.btgpactual.teste.mobile_challenge.data.local.repository.CurrencyValueRepository
import javax.inject.Inject

/**
 * Created by Carlos Souza on 16,October,2020
 */
class CurrencyValueDataSource @Inject constructor(private val currencyValueDAO: CurrencyValueDAO): CurrencyValueRepository {
    override suspend fun insert(data: CurrencyValueEntity): Long? {
        return currencyValueDAO.insert(data)
    }

    override suspend fun insertAll(data: List<CurrencyValueEntity>): List<Long>? {
        return currencyValueDAO.insertAll(data)
    }

    override suspend fun update(data: CurrencyValueEntity): Int? {
        return currencyValueDAO.update(data)
    }

    override suspend fun delete(data: CurrencyValueEntity) {
        return currencyValueDAO.delete(data)
    }

    override fun getByCurrency(currency: String): CurrencyValueEntity? {
        return currencyValueDAO.getByCurrency(currency)
    }

    override fun getAll(): LiveData<List<CurrencyValueEntity>>? {
        return currencyValueDAO.getAll()
    }
}