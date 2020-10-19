package com.btgpactual.teste.mobile_challenge.data.local.repository

import androidx.lifecycle.LiveData
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyEntity

/**
 * Created by Carlos Souza on 16,October,2020
 */
interface CurrencyRepository {

    suspend fun insert(data: CurrencyEntity): Long?
    suspend fun insertAll(data: List<CurrencyEntity>): List<Long>?
    suspend fun update(data: CurrencyEntity): Int?
    suspend fun delete(data: CurrencyEntity)
    fun getAll(): LiveData<List<CurrencyEntity>>? { return null }
    fun getById(id: String): CurrencyEntity? { return null }
}