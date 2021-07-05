package com.example.currencyconverter.utils

import android.text.Editable
import android.text.TextWatcher
import android.widget.EditText
import java.text.NumberFormat
import java.util.*

class MonetaryMask(val input: EditText) {

    fun listen() {
        input.addTextChangedListener(monetaryEntryWatcher)
    }

    private val monetaryEntryWatcher = object : TextWatcher {

        private var currentString: String = ""

        override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            //Nothing to do
        }

        override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
            if (s.toString() != currentString) {
                val myLocale = Locale("pt", "BR")
                input.removeTextChangedListener(this)

                val cleanString = s.toString().replace("[R$,.]".toRegex(), "").trim()
                val parsed: Double = cleanString.toDouble()
                val formatted: String =
                    NumberFormat.getCurrencyInstance(myLocale).format((parsed / 100))
                        .replace("R$", "").trim()
                currentString = formatted

                input.setText(formatted)
                input.setSelection(formatted.length)

                input.addTextChangedListener(this)
            }
        }

        override fun afterTextChanged(s: Editable?) {
            println("Aqui está o valor: $currentString")
        }

    }

}