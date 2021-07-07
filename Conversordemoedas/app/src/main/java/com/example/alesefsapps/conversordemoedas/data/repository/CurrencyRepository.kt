package com.example.alesefsapps.conversordemoedas.data.repository

import com.example.alesefsapps.conversordemoedas.data.result.CurrencyResult
import com.example.alesefsapps.conversordemoedas.data.result.LiveValueResult

interface CurrencyRepository {
    fun getCurrency(currenciesResultCallback: (result: CurrencyResult) -> Unit)
}