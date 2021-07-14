package com.sugarspoon.desafiobtg.utils

import android.text.Editable
import android.text.TextWatcher
import android.widget.EditText
import java.text.NumberFormat
import java.util.*


object CurrencyMask {
    fun unmask(s: String): String {
        return s.replace("[�,.()]".toRegex(), "")
    }

    @Throws(NumberFormatException::class)
    fun parseValue(s: String): Float {
        return try {
            unmask(s).replace("[^0-9]".toRegex(), "").toFloat() / 100
        } catch (ex: Exception) {
            0f
        }
    }

    fun insert(locale: Locale?, ediTxt: EditText): TextWatcher {
        return object : TextWatcher {
            var isUpdating = false
            var old = ""
            override fun onTextChanged(
                s: CharSequence, start: Int, before: Int,
                count: Int
            ) {
                if (isUpdating) {
                    isUpdating = false
                    return
                }
                if (s.toString() != old) {
                    isUpdating = true
                    val cleanString = unmask(s.toString())
                    try {
                        val parsed = cleanString.replace("[^0-9]".toRegex(), "")
                            .toDouble()
                        val formated = NumberFormat.getCurrencyInstance(locale)
                            .format(parsed / 100)
                        setFormattedValue(formated)
                    } catch (e: NumberFormatException) {
                        val formated = NumberFormat.getCurrencyInstance(locale)
                            .format(0)
                        setFormattedValue(formated)
                        e.printStackTrace()
                    }
                }
                if (old.length > s.length && s.length > 0) {
                    old = s.toString()
                    return
                }
            }

            private fun setFormattedValue(formatted: String) {
                var formated = formatted
                try {
                    formated = formated.replace("R$", "")
                    old = formated
                    ediTxt.setText(formated)
                    ediTxt.setSelection(formated.length)
                } catch (e: Exception) {
                }
            }

            override fun beforeTextChanged(
                s: CharSequence, start: Int, count: Int,
                after: Int
            ) {
            }

            override fun afterTextChanged(s: Editable) {}
        }
    }
}