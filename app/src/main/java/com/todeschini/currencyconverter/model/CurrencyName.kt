package com.todeschini.currencyconverter.model

import java.io.Serializable

data class CurrencyName (
    val initials: String,
    val name: String
): Serializable
