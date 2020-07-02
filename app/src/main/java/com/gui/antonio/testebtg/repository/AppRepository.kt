package com.gui.antonio.testebtg.repository

import androidx.lifecycle.LiveData
import com.gui.antonio.testebtg.data.Currencies
import com.gui.antonio.testebtg.data.Quotes
import com.gui.antonio.testebtg.datasource.IAccessDataSource
import javax.inject.Inject

class AppRepository @Inject constructor(private val dataSource: IAccessDataSource) : IAppRepository {
    override fun getListCurrency(): LiveData<List<Currencies>> = dataSource.getListCurrency()
    override fun getListCurrencyOffline(): LiveData<List<Currencies>> = dataSource.getListCurrencyOffline()
    override fun getQuote(symbol:  String): LiveData<Quotes> = dataSource.getQuote(symbol)
    override fun deleteAndInsertQuotes(symbol:List<String>) = dataSource.deleteAndInsertQuotes(symbol)
    override fun getQuoteOffline(symbol: String): LiveData<Quotes> = dataSource.getQuoteOffline(symbol)

}