package br.com.btg.btgchallenge.ui.fragments.controls

import android.text.Editable
import android.text.TextWatcher
import android.widget.EditText
import java.text.NumberFormat
import java.util.*

class EditTextCurrency(val field: EditText) : TextWatcher {
    private var isUpdating = false
    private val nf = NumberFormat.getCurrencyInstance()
    override fun onTextChanged(
        s: CharSequence, start: Int, before: Int,
        after: Int
    ) {

        var s = s
        if (s.length > 6) {
            return
        }

        if (isUpdating) {
            isUpdating = false
            return
        }
        isUpdating = true
        var str = s.toString()
        val hasMask = str.indexOf("$") > -1 || str.indexOf("$") > -1 ||
                str.indexOf(".") > -1 || str.indexOf(",") > -1
        if (hasMask) {
            str = str.replace("[$]".toRegex(), "").replace("[,]".toRegex(), "")
                .replace("[.]".toRegex(), "")
        }
        try {
            val sy = "$"
            str = nf.format(str.toDouble() / 100)
            var nV = str.replace(sy, "")
            nV = nV.replace("\u00A0".toRegex(), "")
            val l = str.length
            field.setText(nV)
            field.setSelection(field.text.length)
        } catch (e: NumberFormatException) {
            s = ""
        }
    }

    override fun afterTextChanged(s: Editable) {}
    override fun beforeTextChanged(
        s: CharSequence,
        start: Int,
        count: Int,
        after: Int
    ) {

    }

}