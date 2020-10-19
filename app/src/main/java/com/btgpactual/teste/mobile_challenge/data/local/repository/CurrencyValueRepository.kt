package com.btgpactual.teste.mobile_challenge.data.local.repository

import androidx.lifecycle.LiveData
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyValueEntity

/**
 * Created by Carlos Souza on 16,October,2020
 */
interface CurrencyValueRepository {

    suspend fun insert(data: CurrencyValueEntity): Long?
    suspend fun insertAll(data: List<CurrencyValueEntity>): List<Long>?
    suspend fun update(data: CurrencyValueEntity): Int?
    suspend fun delete(data: CurrencyValueEntity)
    fun getAll(): LiveData<List<CurrencyValueEntity>>? { return null }
    fun getByCurrency(currency: String): CurrencyValueEntity? { return null }
}