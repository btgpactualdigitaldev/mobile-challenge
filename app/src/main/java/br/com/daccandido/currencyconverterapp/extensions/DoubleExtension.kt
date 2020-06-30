package br.com.daccandido.currencyconverterapp.extensions

import java.text.NumberFormat
import java.util.*


fun Double.formatCurrency (currencyCode: String): String {
    val format: NumberFormat = NumberFormat.getCurrencyInstance(Locale.getDefault())
    format.currency = Currency.getInstance(currencyCode)
    return format.format(this)
}