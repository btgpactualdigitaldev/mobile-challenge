package com.renderson.currency_converter.models

import java.io.Serializable

data class ConversionResult(
    val result: Double,
    val amount: String,
    val originCurrency: String,
    val destinationCurrency: String
): Serializable {
    fun originFormatter(): String {
        return originCurrency.substring(originCurrency.length - 3)
    }
    fun destinationFormatter(): String {
        return destinationCurrency.substring(destinationCurrency.length - 3)
    }
}