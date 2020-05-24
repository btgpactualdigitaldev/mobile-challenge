package com.hotmail.fignunes.btg.repository.local.currency.mappers

import com.hotmail.fignunes.btg.model.Currency
import com.hotmail.fignunes.btg.repository.local.currency.entity.CurrencyBean

class SetCurrency {
    fun toCurrencyBean(currencies: List<Currency>): List<CurrencyBean> {
        return currencies.map {
            CurrencyBean(
                it.id,
                it.description
            )
        }
    }
}