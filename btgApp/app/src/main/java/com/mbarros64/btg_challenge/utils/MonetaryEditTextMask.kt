package com.mbarros64.btg_challenge.utils

import android.text.Editable
import android.text.TextWatcher
import android.widget.EditText
import java.text.NumberFormat.getCurrencyInstance
import java.util.*

class MonetaryEditTextMask {
    companion object {

        private var current = ""

        fun mask(editText: EditText): TextWatcher {
            return object : TextWatcher {
                override fun beforeTextChanged(
                    s: CharSequence?, start: Int, count: Int, after: Int
                ) {
                    println("")
                }

                override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                    if (!s.toString().equals(current)) {
                        val myLocale = Locale("pt", "BR")

                        editText.removeTextChangedListener(this)
                        val cleanString: String = s.toString().replace("""[R$,.]""".toRegex(), "").trim()
                        val parsed = cleanString.toDouble()
                        val formatted: String =
                            getCurrencyInstance(myLocale).format(parsed / 100)
                        current = formatted


                        editText.setText(formatted)
                        editText.setSelection(formatted.length)
                        editText.addTextChangedListener(this)
                    }
                }

                override fun afterTextChanged(s: Editable?) {
                    println(s)
                }
            }
        }
    }
}