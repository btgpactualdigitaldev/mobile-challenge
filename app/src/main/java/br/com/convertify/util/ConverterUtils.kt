package br.com.convertify.util

import br.com.convertify.models.CurrencyItem
import java.math.BigDecimal

class ConverterUtils{
    companion object{
        fun formatStringToDecimal(double: Double): String {
            return BigDecimal(double.toString()).setScale(2, BigDecimal.ROUND_FLOOR).toString()
        }

        fun maskToCurrency(stringValue: String, targetValue: CurrencyItem): String {
            return "${targetValue.code} $stringValue"
        }
    }

    enum class ConversionErrors {
        MISSING_VALUE_TO_CONVERT,
        MISSING_ORIGIN_CURRENCY,
        MISSING_TARGET_CURRENCY,
        UNEXPECTED_ERROR
    }


}