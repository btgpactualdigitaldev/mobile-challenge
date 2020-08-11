package com.svm.btgmoneyconverter.utils

import android.content.Context
import android.text.Editable
import android.widget.Toast
import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import java.util.*

object CommonFunctions {

    private val decimalFormat = DecimalFormat(CONVERT_MASK)

    fun replaceCharConverterActivity(labelText: String, cName: String, cSymbol: String): String {
        return "$labelText $cName ($cSymbol)"
    }

    fun showMessageShort(context: Context, text: String) = Toast.makeText(context, text, Toast.LENGTH_SHORT).show()

    fun doubleToString(value: Double): String{
        return decimalFormat.format(value)
    }

    fun stringReplaceComma(value: String): String = value.replace(",",".")


}