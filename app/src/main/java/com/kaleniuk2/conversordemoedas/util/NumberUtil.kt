package com.kaleniuk2.conversordemoedas.util

import java.math.BigDecimal

object NumberUtil {
    fun parseStringToBigDecimal(value: String, decimal: Int = 2): BigDecimal {
        val cleanString = value.replace("R$", "")
            .replace(",","")
            .replace(".","")
            .trim()
        return try {
            val convertedValue = BigDecimal(cleanString).setScale(
                decimal, BigDecimal.ROUND_CEILING
            ).divide(BigDecimal(100), BigDecimal.ROUND_CEILING)
            convertedValue
        } catch (e: NumberFormatException) {
            BigDecimal(0)
        }
    }
}