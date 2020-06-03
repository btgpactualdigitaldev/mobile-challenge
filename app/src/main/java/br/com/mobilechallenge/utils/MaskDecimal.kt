package br.com.mobilechallenge.utils

import android.text.Editable
import android.text.TextWatcher
import android.widget.EditText
import java.text.NumberFormat
import java.util.*

class MaskDecimal(val campo: EditText) : TextWatcher {
    private var isUpdating = false
    private val locale = Locale("en", "US")

    private val nf = NumberFormat.getCurrencyInstance(locale)
    override fun onTextChanged(
        s: CharSequence,
        start: Int,
        before: Int,
        count: Int
    ) {
        // Evita que o metodo seja executado varias vezes.
        // Se tirar ele entre em loop
        if (isUpdating) {
            isUpdating = false
            return
        }

        // seta com o true
        isUpdating = true
        setValue(s)
    }

    private fun setValue(s: CharSequence) {
        var s = s
        var str = s.toString()
        str = umask(str)
        try {
            // Transformamos o numero que esta escrito no EditText em monetario.
            str = nf.format(str.toDouble() / 100)
            str = str.replace("US$", "US$ ")

            // coloca o texto no campo
            campo.setText(str)
            campo.setSelection(campo.text.length)
        }
        catch (e: NumberFormatException) {
            s = ""
        }
    }

    /**
     * Method to clear old mask
     *
     * @param str
     * @return
     */
    private fun umask(str: String): String {
        // Verifica se ja existe a mascara no texto.
        var str = str
        val hasMask =
            (str.indexOf("US$") > -1 || str.indexOf("$") > -1) && (str.indexOf(".") > -1 || str.indexOf(
                ","
            ) > -1)

        // Verificamos se existe mascara
        if (hasMask) {
            // Retiramos a mascara.
            str = str.replace("[US$]".toRegex(), "").replace("[,]".toRegex(), "")
                .replace("[.]".toRegex(), "")
        }
        return str
    }

    override fun beforeTextChanged(
        s: CharSequence,
        start: Int,
        count: Int,
        after: Int
    ) {
    }

    override fun afterTextChanged(s: Editable) {}

    /**
     * Constructor
     *
     * @param campo
     */
    init {
        setValue(campo.editableText.toString())
    }
}