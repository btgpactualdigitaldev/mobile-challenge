package br.dev.infra.btgconversiontool.ui.calculator

import br.dev.infra.btgconversiontool.data.*
import br.dev.infra.btgconversiontool.network.CurrencyApiHelper
import br.dev.infra.btgconversiontool.room.CurrencyDatabaseDao
import javax.inject.Inject

class CalculatorRepository @Inject constructor(
    private val currencyDatabaseDao: CurrencyDatabaseDao,
    private val currencyApi: CurrencyApiHelper
) {

    //Inserts
    suspend fun insertCurrency(currencyTable: CurrencyTable) {
        currencyDatabaseDao.insertCurrency(currencyTable)
    }

    suspend fun insertQuotes(quotesTable: QuotesTable) {
        currencyDatabaseDao.insertQuotes(quotesTable)
    }

    suspend fun insertTimestamp(timestamp: TimestampTable) {
        currencyDatabaseDao.insertTimestamp(timestamp)
    }


    //Queries
    suspend fun getListApi(): CurrencyList {
        return currencyApi.getListApi()
    }

    suspend fun getQuotesApi(): CurrencyQuotes {
        return currencyApi.getQuotesApi()
    }

    suspend fun getAllCurrenciesDB(): List<CurrencyTable>? = currencyDatabaseDao.getAllCurrency()

    suspend fun getTimestampDB(): String = currencyDatabaseDao.getTimestamp()

    suspend fun getQuotesDb(id: String): Float = currencyDatabaseDao.getQuote(id)


    //Delete
    suspend fun clearAllTables() {
        currencyDatabaseDao.clearCurrency()
        currencyDatabaseDao.clearQuotes()
        currencyDatabaseDao.clearTimestamp()
    }


}