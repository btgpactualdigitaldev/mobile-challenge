package com.sugarspoon.desafiobtg.utils.extensions

import java.math.RoundingMode
import java.text.NumberFormat
import java.util.*

fun Float.formatCurrencyBRL(showCurrency: Boolean = true, nearestRounding: Boolean = false): String {
    val locale = Locale("pt", "BR")
    val value = this.formatToCurrency(locale, nearestRounding)
    return if (showCurrency) value else value.replace("R$", "")
}

fun Float.formatToCurrency(locale: Locale, nearestRounding: Boolean): String {
    val currencyFormatter = NumberFormat.getCurrencyInstance(locale).apply {
        roundingMode = if(nearestRounding) RoundingMode.HALF_UP else RoundingMode.FLOOR
    }
    return currencyFormatter.format(this.toBigDecimal())
}