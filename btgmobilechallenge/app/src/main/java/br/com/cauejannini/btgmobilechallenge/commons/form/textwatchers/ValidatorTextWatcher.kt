package br.com.cauejannini.btgmobilechallenge.commons.form.textwatchers

import android.text.Editable
import android.text.TextWatcher
import android.widget.EditText

/**
 * Created by user on 16/01/18.
 */
abstract class ValidatorTextWatcher : TextWatcher {

    private var formInterface: WatchableField? = null
    protected var editText: EditText
    private var lastValidated: String? = null

    constructor(editText: EditText) {
        this.editText = editText
    }

    constructor(formInterface: WatchableField) {
        this.formInterface = formInterface
        editText = this.formInterface!!.editText

        val valor = editText.text.toString()
        val valido = valida(valor)
        this.formInterface!!.afterTextChanged(valido, valor)
    }

    override fun beforeTextChanged(s: CharSequence, start: Int, count: Int, after: Int) {}

    override fun onTextChanged(s: CharSequence, start: Int, before: Int, count: Int) {}

    override fun afterTextChanged(s: Editable) {
        if (formInterface != null) {
            val current = s.toString()
            if (current != lastValidated) {
                lastValidated = current
                val valido = valida(current)
                formInterface!!.afterTextChanged(valido, current)
            }
        }
    }


    protected abstract fun valida(valor: String): Boolean

    interface WatchableField {
        var editText: EditText
        fun afterTextChanged(valid: Boolean, text: String)
    }
}