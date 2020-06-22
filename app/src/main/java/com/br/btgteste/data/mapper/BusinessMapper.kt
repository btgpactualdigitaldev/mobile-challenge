package com.br.btgteste.data.mapper

import com.br.btgteste.data.local.entity.CurrencyTb
import com.br.btgteste.domain.model.Currency

object BusinessMapper {

    fun convertCurrencyDbToCurrency(currencies: List<CurrencyTb>) = currencies.map { Currency(it.code, it.name) }
    fun convertCurrencyToCurrencyDb(currencies: List<Currency>) = currencies.map { CurrencyTb(code = it.code, name = it.name) }
}