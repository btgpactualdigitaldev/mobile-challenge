package br.com.cauejannini.btgmobilechallenge.commons.form.validators

/**
 * Created by cauejannini on 14/03/2018.
 */
interface Validator {
    fun validate(text: String?): ValidationResult?
}