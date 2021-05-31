package com.example.desafiobtg.ui.convert

import android.widget.EditText
import com.example.desafiobtg.utilities.Constants

class ConvertCalc() {

    fun currencyToDollar(livePriceList: Map<String, Double>?): Double? {

        livePriceList?.forEach {
            val s = it.key.substring(3)
            if (s == Constants.Api.MAIN_CURRENCY) {

                Constants.Api.MAIN_CURRENCY_VALUE = it.value
            }
        }
        return livePriceList?.getValue("USDUSD")?.div(Constants.Api.MAIN_CURRENCY_VALUE)
    }

    fun tobeConvertedCurrencyValue(livePriceList: Map<String, Double>?): Double {
        livePriceList?.forEach {
            val s = it.key.substring(3)
            if (s == Constants.Api.TO_BE_CONVERTED_CURRENCY) {
                Constants.Api.TO_BE_CONVERTED_CURRENCY_VALUE = it.value
            }
        }
        return Constants.Api.TO_BE_CONVERTED_CURRENCY_VALUE
    }

    fun desireValue(editText: EditText): Double{
        val value = editText.text.toString()
        return value.toDouble()
    }
}

