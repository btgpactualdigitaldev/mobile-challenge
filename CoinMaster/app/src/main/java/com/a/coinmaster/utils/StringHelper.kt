package com.a.coinmaster.utils

import com.a.coinmaster.utils.ConstantUtils.Companion.MAX_DECIMAL_DIGITS
import com.a.coinmaster.utils.ConstantUtils.Companion.MIN_DECIMAL_DIGITS
import java.util.Locale

fun decimalMaskAutoFormat(
    value: String,
    minimumFractionDigits: Int = MIN_DECIMAL_DIGITS,
    maximumFractionDigits: Int = MAX_DECIMAL_DIGITS
): String {
    // Turn double value text in integer value text
    val onlyNumbers = value.replace(Regex("[^\\d]"), "")
    val bigIntRaw = onlyNumbers.toBigIntegerOrNull() ?: 0.toBigInteger()
    // Set size of format with zero
    val integerFormatted =
        String.format(
            Locale.getDefault(),
            "%0${maximumFractionDigits}d",
            bigIntRaw
        )

    var doubleText = integerFormatted

    if (integerFormatted.length > maximumFractionDigits) {
        doubleText = integerFormatted
            .reversed()
            .substring(0 until maximumFractionDigits) + "." +
                integerFormatted
                    .reversed()
                    .substring(maximumFractionDigits)
        doubleText = doubleText.reversed()
    } else {
        val doubleFormated =
            integerFormatted.padStart(maximumFractionDigits, '0')
        doubleText = "0.$doubleFormated"
    }
    val resultDouble = doubleText.toDoubleOrNull() ?: 0.0
    return formatDoubleToString(
        resultDouble,
        minimumFractionDigits = minimumFractionDigits,
        maximumFractionDigits = maximumFractionDigits
    )
}