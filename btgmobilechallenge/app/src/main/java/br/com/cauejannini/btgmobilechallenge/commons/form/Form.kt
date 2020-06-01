package br.com.cauejannini.btgmobilechallenge.commons.form

import android.view.View
import java.util.*

/**
 * Created by cauejannini on 16/01/2018.
 */
class Form(private val btAction: View?) {

    private val fields = ArrayList<Validatable>()

    init {
        checkButtonStatus()
    }

    fun addValidatable(field: Validatable) {
        fields.add(field)
        field.form = this
        checkButtonStatus()
    }

    fun removeValidatable(fieldToRemove: Validatable?) {
        if (fieldToRemove != null) {
            val iter = fields.iterator()
            while (iter.hasNext()) {
                val field = iter.next()
                if (field == fieldToRemove) {
                    field.form = null
                    iter.remove()
                }
            }
            checkButtonStatus()
        }
    }

    private fun checkButtonStatus() {
        if (btAction != null) btAction.isEnabled = isValid
    }

    val isValid: Boolean
        get() {
            for (item in fields) {
                if (!item.isValid) {
                    return false
                }
            }
            return true
        }

    fun validadeReceiver(valido: Boolean) {
        if (valido) {
            checkButtonStatus()
        } else {
            if (btAction != null) btAction.isEnabled = false
        }
    }

    interface Validatable {
        var form: Form?
        val isValid: Boolean
    }

}