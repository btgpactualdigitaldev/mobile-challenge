package com.btg.teste.repository.dataManager.dao;

import androidx.room.Dao
import androidx.room.Query
import com.btg.teste.repository.dataManager.entity.CurrenciesEntity

@Dao
abstract class CurrenciesDAO : IDao<CurrenciesEntity>() {

    @Query("SELECT * FROM CURRENCIES WHERE ID = :id")
    abstract fun findViewById(id: Int): CurrenciesEntity?

    @Query("SELECT * FROM CURRENCIES")
    abstract fun find(): List<CurrenciesEntity>

    @Query("SELECT * FROM CURRENCIES ORDER BY ID DESC LIMIT 1")
    abstract fun findDesc(): CurrenciesEntity?

    @Query("SELECT * FROM CURRENCIES WHERE CURRENCY = :currency")
    abstract fun findViewByCurrency(currency: String): CurrenciesEntity?

}