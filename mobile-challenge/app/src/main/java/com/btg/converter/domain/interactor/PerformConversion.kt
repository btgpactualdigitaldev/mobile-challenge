package com.btg.converter.domain.interactor

import com.btg.converter.domain.entity.quote.CurrentQuotes
import com.btg.converter.domain.util.form.ConversionForm

class PerformConversion {

    fun execute(
        conversionForm: ConversionForm,
        currentQuotes: CurrentQuotes
    ): Double? {
        val originCurrencyQuote =
            currentQuotes.quotes.find { it.currencyCode == conversionForm.originCurrency?.code }
        val destinationCurrencyQuote =
            currentQuotes.quotes.find { it.currencyCode == conversionForm.destinationCurrency?.code }

        val totalConversionValue = nullableMultiplication(
            destinationCurrencyQuote?.convertedValue,
            conversionForm.conversionValue
        )

        return nullableDivision(totalConversionValue, originCurrencyQuote?.convertedValue)
    }

    private fun nullableDivision(firstDouble: Double?, secondDouble: Double?): Double? {
        return if (firstDouble == null || secondDouble == null) {
            null
        } else {
            firstDouble / secondDouble
        }
    }

    private fun nullableMultiplication(firstDouble: Double?, secondDouble: Double?): Double? {
        return if (firstDouble == null || secondDouble == null) {
            null
        } else {
            firstDouble * secondDouble
        }
    }
}