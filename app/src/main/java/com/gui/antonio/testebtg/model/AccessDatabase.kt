package com.gui.antonio.testebtg.model

import com.gui.antonio.testebtg.data.Currencies
import com.gui.antonio.testebtg.data.Quotes
import com.gui.antonio.testebtg.database.AppDao
import javax.inject.Inject

class AccessDatabase @Inject constructor(private val dao: AppDao) : IAccessDatabase {

    override fun getCurrencies(): List<Currencies> = dao.getCurrencies()

    override fun insertCurrencies(currenciesData: List<Currencies>) = dao.insertCurrencies(currenciesData)

    override fun deleteCurrencies() = dao.deleteCurrencies()

    override fun getQuote(symbol : String): Quotes = dao.getQuote(symbol)

    override fun insertQuotes(quotes: List<Quotes>) = dao.insertQuotes(quotes)

    override fun deleteQuotes() = dao.deleteQuotes()
}