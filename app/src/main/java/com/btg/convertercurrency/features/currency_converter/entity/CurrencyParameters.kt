package com.btg.convertercurrency.features.currency_converter.entity

import com.btg.convertercurrency.features.base_entity.CurrencyItem
import java.math.BigDecimal
import java.math.RoundingMode
import java.text.NumberFormat
import java.util.*

class CurrencyParameters(
    val from: CurrencyItem = CurrencyItem(),
    val to: CurrencyItem = CurrencyItem(),
    var value: String = ""
) {
    private val numberFormat = NumberFormat.getCurrencyInstance().apply {
        minimumFractionDigits = 1
        maximumFractionDigits = 2
    }

    fun convertFromCurrencyForToCurrence(): String {

        val value = if (value.isNullOrEmpty()) "0" else value

        val valueConverter = getBigDecimalConfigurade(value)

        val valorToEmDolar = valueConverter.divide(
            getBigDecimalConfigurade(to.quotesList.first().quote),
            6,
            RoundingMode.HALF_EVEN
        )

        numberFormat.currency = Currency.getInstance(from.code)

        return numberFormat.format(getBigDecimalConfigurade(from.quotesList.first().quote)
            .multiply(valorToEmDolar).setScale(2, RoundingMode.HALF_EVEN))
    }

    private fun getBigDecimalConfigurade(converter: String): BigDecimal {
        return BigDecimal(converter).apply {
            setScale(6, RoundingMode.HALF_EVEN)
        }
    }
}