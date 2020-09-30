package com.btgpactual.currencyconverter.util

import java.text.DecimalFormat

fun addCommaCollection(value: String): String {
    var text = value
    val splittedNum = text.split("\\.".toRegex()).toTypedArray()
    var decimalNum = ""
    if (splittedNum.size == 2) {
        text = splittedNum[0]
        decimalNum = "." + splittedNum[1]
    }
    val inputDouble = text.toDouble()
    val myFormatter = DecimalFormat("###,###")
    var output = myFormatter.format(inputDouble)
    decimalNum = decimalNum.replace(".", ",")
    output = output.replace(",", ".")
    return output + decimalNum
}
