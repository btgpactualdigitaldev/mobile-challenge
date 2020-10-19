package com.btgpactual.teste.mobile_challenge.data.local.dao

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Query
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyValueEntity

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Dao
abstract class CurrencyValueDAO : BaseDAO<CurrencyValueEntity> {

    @Query("SELECT * FROM currency_value")
    abstract fun getAll(): LiveData<List<CurrencyValueEntity>>

    @Query("SELECT * FROM currency_value WHERE currency = :currency")
    abstract fun getByCurrency(currency: String): CurrencyValueEntity
}