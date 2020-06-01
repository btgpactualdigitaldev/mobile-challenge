package br.com.cauejannini.btgmobilechallenge.commons.form.validators

/**
 * Created by cauejannini on 14/03/2018.
 */
class ValidationResult(val isValid: Boolean, private val message: String?) {

    fun getMessage(): String {
        return message ?: if (isValid) "Campo válido" else "Campo inválido"
    }

}