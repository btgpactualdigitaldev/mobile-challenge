package com.hotmail.fignunes.btg.presentation.currencies

import com.hotmail.fignunes.btg.model.Currency

interface CurrenciesContract {
    fun message(error: Int)
    fun initializeAdapter(currencies: List<Currency>)
}