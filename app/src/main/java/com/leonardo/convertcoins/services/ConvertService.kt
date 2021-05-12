package com.leonardo.convertcoins.services

import com.leonardo.convertcoins.models.Rate
import java.math.BigDecimal
import java.math.RoundingMode
import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import java.util.*

class ConvertService {

    companion object {
        /**
         * create default application DecimalFormat so it can be show to the user
         * using "dot (.)" as thousand separator and "comma (,)" as decimal separator
         */
        private fun getDecimalFormat(forceZeros: Boolean = true): DecimalFormat {
            val pattern = if (forceZeros) "#,##0.00" else "#,###.##"
            val otherSymbols = DecimalFormatSymbols(Locale.ROOT)
            otherSymbols.decimalSeparator = ','
            otherSymbols.groupingSeparator = '.'
            return DecimalFormat(pattern, otherSymbols)
        }
    }
    /**
     * Convert input value from currency I have to the respective amount on the currency
     * I want based on both rates related to the USD coin
     * @param rateIHave being the rate of the coin I have related to the USD coin
     * @param rateIWant bing the rate of the coin I want related to the USD coin
     * @param toConvertValue inputed value
     * @return the respective amount from toConvertedValue converted to the new currency
     */
    fun convert(rateIHave: Rate, rateIWant: Rate, toConvertValue: BigDecimal): BigDecimal {
        if (rateIHave.value <= 0 || rateIWant.value <= 0 || toConvertValue <= BigDecimal.ZERO)
            return BigDecimal.ZERO

        return toConvertValue.multiply((rateIWant.value / rateIHave.value).toBigDecimal()).setScale(10, RoundingMode.FLOOR)
    }

    /**
     * Access sent quotes map and return the rate of that coin related to the USD coin
     * @param coin as AUD which will be a quotes key as "USDAUD"
     * @param quotes map that contains all available quotes related to USD coin
     * @return a single quote related to USD coin as 1.213
     */
    fun getCurrentRate(coin: String, quotes: Map<String, Double>): Double {
        val key = "USD$coin"
        if (key in quotes.keys) {
            return quotes["USD$coin"]!!
        }
        return 0.0
    }

    /** Format bigDecimal to final value string with proper dots and commas
     * @param convertedValue final value to be printed on the screen
     * @return formatted value as 943.23,10
     */
    fun getFormattedValue(convertedValue: BigDecimal): String {
        val df = getDecimalFormat()
        return df.format(convertedValue)
    }

}