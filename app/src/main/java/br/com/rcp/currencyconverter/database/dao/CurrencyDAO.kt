package br.com.rcp.currencyconverter.database.dao

import androidx.room.Dao
import androidx.room.Query
import br.com.rcp.currencyconverter.database.dao.base.BaseDAO
import br.com.rcp.currencyconverter.database.entities.Currency

@Dao
abstract class CurrencyDAO: BaseDAO<Currency>() {
    @Query("select * from currency where identifier = :identifier")
    abstract fun findOne(identifier: String): Currency?

    @Query("update currency set value = :value where identifier = :identifier")
    abstract fun putValue(identifier: String, value: Double): Int

    @Query("select * from currency")
    abstract fun findAll(): List<Currency>?
}