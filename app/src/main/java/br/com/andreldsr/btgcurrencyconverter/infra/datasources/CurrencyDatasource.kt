package br.com.andreldsr.btgcurrencyconverter.infra.datasources

import br.com.andreldsr.btgcurrencyconverter.data.model.CurrencyEntity
import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency

interface CurrencyDatasource {
    suspend fun getCurrencies(): List<Currency>
    suspend fun getQuote(currencyInitials: String): Float
    suspend fun save(currency: CurrencyEntity): Long
    suspend fun deleteAll()
}