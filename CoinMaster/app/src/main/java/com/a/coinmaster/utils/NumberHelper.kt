package com.a.coinmaster.utils

import com.a.coinmaster.utils.ConstantUtils.Companion.MAX_DECIMAL_DIGITS
import com.a.coinmaster.utils.ConstantUtils.Companion.MIN_DECIMAL_DIGITS
import java.text.DecimalFormat

fun formatDoubleToString(
    value: Double,
    maximumFractionDigits: Int = MAX_DECIMAL_DIGITS,
    minimumFractionDigits: Int = MIN_DECIMAL_DIGITS
): String {
    try {
        val instance = DecimalFormat.getInstance()
        instance.maximumFractionDigits = maximumFractionDigits
        instance.minimumFractionDigits = minimumFractionDigits
        return instance.format(value)
    } catch (e: Exception) {
        e.printStackTrace()
        return String.format("%.0${MAX_DECIMAL_DIGITS}f", value)
    }
}

fun formatStringToDouble(
    value: String,
    maximumFractionDigits: Int = MAX_DECIMAL_DIGITS,
    minimumFractionDigits: Int = MIN_DECIMAL_DIGITS
): Double {
    try {
        val instance = DecimalFormat.getInstance()
        instance.maximumFractionDigits = maximumFractionDigits
        instance.minimumFractionDigits = minimumFractionDigits
        return instance.parse(value)?.toDouble() ?: 0.0
    } catch (e: Exception) {
        e.printStackTrace()
        return 0.0
    }
}