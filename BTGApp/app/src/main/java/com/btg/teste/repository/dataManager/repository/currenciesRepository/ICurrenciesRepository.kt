package com.btg.teste.repository.dataManager.repository.currenciesRepository

import com.btg.teste.repository.dataManager.entity.CurrenciesEntity
import com.btg.teste.repository.dataManager.repository.IRepository


/**
 * Created by dev on 13/05/2018.
 */
interface ICurrenciesRepository : IRepository<CurrenciesEntity> {
    fun findViewById(id: Int): CurrenciesEntity?
    fun findViewByCurrency(currency: String): CurrenciesEntity?
    fun findDesc(): CurrenciesEntity?
    fun find(): List<CurrenciesEntity>?
}