@file:Suppress("RECEIVER_NULLABILITY_MISMATCH_BASED_ON_JAVA_ANNOTATIONS")

package com.btg.conversormonetario.shared

import java.math.BigDecimal
import java.text.NumberFormat
import java.util.*

fun BigDecimal.toCurrency(codeSelected: String): String {
    return NumberFormat.getCurrencyInstance(Locale("pt", "BR"))
        .format(this)
        .replace("R$", "$codeSelected ").trim()
}

fun String.currencyToBigDecimal(): BigDecimal {
    return try {
        val resultStr = this.replace(Regex("[^0-9,]"), "").replace(",", ".")
        NumberFormat.getCurrencyInstance(Locale("pt", "BR")).parse(resultStr).toDouble()
            .toBigDecimal()
    } catch (e: Exception) {
        BigDecimal.ZERO
    }
}



