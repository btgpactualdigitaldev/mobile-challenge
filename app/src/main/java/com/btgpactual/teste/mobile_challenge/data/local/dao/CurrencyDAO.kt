package com.btgpactual.teste.mobile_challenge.data.local.dao

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Query
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyEntity

@Dao
abstract class CurrencyDAO : BaseDAO<CurrencyEntity> {
    @Query("SELECT * FROM currency ORDER BY id")
    abstract fun getAll(): LiveData<List<CurrencyEntity>>

    @Query("SELECT * FROM currency WHERE id = :id")
    abstract fun getById(id: String): CurrencyEntity
}