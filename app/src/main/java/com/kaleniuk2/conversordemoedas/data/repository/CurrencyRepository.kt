package com.kaleniuk2.conversordemoedas.data.repository

import com.kaleniuk2.conversordemoedas.data.DataWrapper
import com.kaleniuk2.conversordemoedas.data.model.Currency

interface CurrencyRepository {
    fun getListCurrency(callback: (DataWrapper<List<Currency>>) -> Unit)
    fun convert(currencyFrom: String, currencyTo: String, callback: (DataWrapper<List<Currency>>) -> Unit)
}