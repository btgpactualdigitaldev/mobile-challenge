package com.renderson.currency_converter.models

data class Quotes(
    val currency: String,
    val quote: String
) {
    override fun toString(): String {
        return currency.substring(currency.length - 3)
    }
}