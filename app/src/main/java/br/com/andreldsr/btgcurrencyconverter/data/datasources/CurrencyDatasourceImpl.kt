package br.com.andreldsr.btgcurrencyconverter.data.datasources

import android.os.Build
import androidx.annotation.RequiresApi
import br.com.andreldsr.btgcurrencyconverter.data.dao.CurrencyDAO
import br.com.andreldsr.btgcurrencyconverter.data.model.CurrencyEntity
import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency
import br.com.andreldsr.btgcurrencyconverter.infra.datasources.CurrencyDatasource
import java.time.LocalDate
import java.time.LocalDateTime
import java.util.*

class CurrencyDatasourceImpl(val currencyDAO: CurrencyDAO) : CurrencyDatasource {
    override suspend fun getCurrencies(): List<Currency> {
        val currencieEntityList = currencyDAO.getAll()
        return currencieEntityList.map { currencyEntity ->
            Currency(name = currencyEntity.name, initials = currencyEntity.initials)
        }.toList()
    }

    override suspend fun getQuote(currencyInitials: String): Float {
        return currencyDAO.getQuote(currencyInitials)
    }


    override suspend fun save(currency: CurrencyEntity): Long {
        return currencyDAO.save(currency)
    }

    override suspend fun deleteAll() {
        currencyDAO.deleteAll()
    }
}