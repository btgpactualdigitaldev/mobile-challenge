package com.btg.converter.domain.util.form

import com.btg.converter.domain.entity.currency.Currency

class ConversionForm() {

    var originCurrency: Currency? = null
    var destinationCurrency: Currency? = null
    var conversionValue: Double? = null

    fun isCurrenciesEmpty(): Boolean {
        return (originCurrency == null || destinationCurrency == null)
    }

    fun isValueEmpty(): Boolean {
        return (conversionValue == null)
    }
}