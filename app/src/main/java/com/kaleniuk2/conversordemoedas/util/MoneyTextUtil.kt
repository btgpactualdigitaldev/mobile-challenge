package com.kaleniuk2.conversordemoedas.util

import android.text.Editable
import android.text.TextWatcher
import android.widget.EditText
import java.lang.ref.WeakReference
import java.math.BigDecimal
import java.text.NumberFormat
import java.util.*


class MoneyTextWatcher(editText: EditText?) : TextWatcher {
    private val editTextWeakReference: WeakReference<EditText?>?
    private val locale: Locale? = Locale("pt","BR")
    private var current = ""
    override fun beforeTextChanged(
        s: CharSequence?,
        start: Int,
        count: Int,
        after: Int
    ) {
    }

    override fun onTextChanged(
        s: CharSequence?,
        start: Int,
        before: Int,
        count: Int
    ) {
        if (s.toString() != current) {
            val editText: EditText = editTextWeakReference?.get() ?: return
            editText.removeTextChangedListener(this)
            val parsed: BigDecimal? = parseToBigDecimal(s.toString())
            val formatted: String = NumberFormat
                .getCurrencyInstance(locale)
                .format(parsed)
                .replace("R$", "")
                .trim()

            current = formatted

            editText.setText(formatted)
            editText.setSelection(formatted.length)
            editText.addTextChangedListener(this)
        }
    }

    override fun afterTextChanged(editable: Editable?) {}

    private fun parseToBigDecimal(value: String?): BigDecimal? {
        return NumberUtil.parseStringToBigDecimal(value.toString())
    }

    init {
        editTextWeakReference = WeakReference(editText)
    }
}