package com.kaleniuk2.conversordemoedas.data.repository

import com.kaleniuk2.conversordemoedas.data.DataWrapper
import com.kaleniuk2.conversordemoedas.data.model.Currency
import com.kaleniuk2.conversordemoedas.data.remote.CurrencyRemoteDataSource

class CurrencyRepositoryImpl : CurrencyRepository {
    override fun getListCurrency(callback: (DataWrapper<List<Currency>>) -> Unit) {
        CurrencyRemoteDataSource<DataWrapper<List<Currency>>> {
            callback(it)
        }.execute(CurrencyRemoteDataSource.ENDPOINT.LIST)
    }

    override fun convert(
        currencyFrom: String,
        currencyTo: String, callback: (DataWrapper<List<Currency>>) -> Unit) {
        val live = CurrencyRemoteDataSource.ENDPOINT.LIVE
        live.additionalParams = "$currencyFrom,$currencyTo"
        CurrencyRemoteDataSource<DataWrapper<List<Currency>>> {
            callback(it)
        }.execute(live)
    }


}