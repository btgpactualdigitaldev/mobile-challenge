package com.renderson.currency_converter.repository

import com.renderson.currency_converter.api.ApiHelper
import com.renderson.currency_converter.other.Resource
import javax.inject.Inject

class CurrencyRepository @Inject constructor(
    private val apiHelper: ApiHelper
) {
    suspend fun getAllCurrencies() = apiHelper.getAllCurrencies()

    suspend fun getAllQuotes() = apiHelper.getQuotes()
}