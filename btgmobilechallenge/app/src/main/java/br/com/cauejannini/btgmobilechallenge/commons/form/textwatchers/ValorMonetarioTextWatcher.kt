package br.com.cauejannini.btgmobilechallenge.commons.form.textwatchers

import android.text.Editable
import android.widget.EditText
import br.com.cauejannini.btgmobilechallenge.commons.form.validators.Validations.validarValorMonetario

/**
 * Created by cauejannini on 24/04/17.
 */
class ValorMonetarioTextWatcher : ValidatorTextWatcher {

    var cifrao: String? = null

    constructor (editText: EditText) : super(editText) {}

    constructor (formInterface: WatchableField) : super(formInterface) {}

    constructor (formInterface: WatchableField, cifrao: String?) : super(formInterface) {
        this.cifrao = cifrao
    }

    override fun beforeTextChanged(s: CharSequence, start: Int, count: Int, after: Int) {}

    override fun onTextChanged(s: CharSequence, start: Int, before: Int, count: Int) {}

    override fun afterTextChanged(editable: Editable) {

        var str = editable.toString()

        if (cifrao != null) {
            str = str.replace(cifrao!!, "").trim { it <= ' ' }
            str = str.replace(cifrao!!.substring(0, cifrao!!.length - 1), "").trim { it <= ' ' }
        }

        if (str != "") {

            var clean = str.replace(".", "").replace(",", "")

            val stringBuilder = StringBuilder(clean)

            while (stringBuilder.length > 0 && stringBuilder[0] == '0') {
                stringBuilder.deleteCharAt(0)
            }

            clean = stringBuilder.toString()
            val countChar = clean.length

            str = if (countChar > 19) {
                clean.substring(countChar - 19, countChar - 17) + "." + clean.substring(countChar - 17, countChar - 14) + "." + clean.substring(countChar - 14, countChar - 11) + "." + clean.substring(countChar - 11, countChar - 8) + "." + clean.substring(countChar - 8, countChar - 5) + "." + clean.substring(countChar - 5, countChar - 2) + "," + clean.substring(countChar - 2)
            } else if (countChar > 17) {
                clean.substring(0, countChar - 17) + "." + clean.substring(countChar - 17, countChar - 14) + "." + clean.substring(countChar - 14, countChar - 11) + "." + clean.substring(countChar - 11, countChar - 8) + "." + clean.substring(countChar - 8, countChar - 5) + "." + clean.substring(countChar - 5, countChar - 2) + "," + clean.substring(countChar - 2)
            } else if (countChar > 14) {
                clean.substring(0, countChar - 14) + "." + clean.substring(countChar - 14, countChar - 11) + "." + clean.substring(countChar - 11, countChar - 8) + "." + clean.substring(countChar - 8, countChar - 5) + "." + clean.substring(countChar - 5, countChar - 2) + "," + clean.substring(countChar - 2)
            } else if (countChar > 11) {
                clean.substring(0, countChar - 11) + "." + clean.substring(countChar - 11, countChar - 8) + "." + clean.substring(countChar - 8, countChar - 5) + "." + clean.substring(countChar - 5, countChar - 2) + "," + clean.substring(countChar - 2)
            } else if (countChar > 8) {
                clean.substring(0, countChar - 8) + "." + clean.substring(countChar - 8, countChar - 5) + "." + clean.substring(countChar - 5, countChar - 2) + "," + clean.substring(countChar - 2)
            } else if (countChar > 5) {
                clean.substring(0, countChar - 5) + "." + clean.substring(countChar - 5, countChar - 2) + "," + clean.substring(countChar - 2)
            } else if (countChar > 2) {
                clean.substring(0, countChar - 2) + "," + clean.substring(countChar - 2)
            } else if (countChar == 2) {
                "0,$clean"
            } else if (countChar == 1) {
                "0,0$clean"
            } else {
                "0,00"
            }
        }

        editText.removeTextChangedListener(this)
        val filters = editable.filters
        editable.filters = arrayOf()
        val newString = if (cifrao != null) "$cifrao $str" else str
        editable.replace(0, editable.length, newString)
        editable.filters = filters
        editText.setSelection(editText.length())
        editText.addTextChangedListener(this)

        super.afterTextChanged(editable)
    }

    override fun valida(valor: String): Boolean {
        return validarValorMonetario(valor).isValid
    }
}