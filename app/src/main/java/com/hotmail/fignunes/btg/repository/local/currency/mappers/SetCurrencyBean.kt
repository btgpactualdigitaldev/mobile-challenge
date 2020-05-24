package com.hotmail.fignunes.btg.repository.local.currency.mappers

import com.hotmail.fignunes.btg.model.Currency
import com.hotmail.fignunes.btg.repository.local.currency.entity.CurrencyBean

class SetCurrencyBean {
    fun toCurrency(currencyBeans: List<CurrencyBean>): List<Currency> {
        return currencyBeans.map {
            Currency(
                it.id,
                it.description
            )
        }
    }
}