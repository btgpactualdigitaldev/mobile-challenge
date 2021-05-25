package com.vald3nir.data.repository

import com.vald3nir.data.database.DatabaseHandler
import com.vald3nir.data.database.model.CurrencyView
import com.vald3nir.data.rest.RestClient

class DataRepository(private val database: DatabaseHandler, private val restClient: RestClient) {

    suspend fun fillDatabase() {
        try {
            database.updateCurrencies(restClient.listCurrencies())
            database.updateExchanges(restClient.listExchanges())
            database.close()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun listCurrencies(): List<CurrencyView>? {
        return database.listAllCurrenciesWithFlag()
    }

    fun getCurrency(code: String?): CurrencyView? {
        return database.getCurrencyWithFlag(code)
    }
}