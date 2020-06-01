package br.com.cauejannini.btgmobilechallenge.commons.form.validators

import br.com.cauejannini.btgmobilechallenge.commons.Utils.doisDecimais
import br.com.cauejannini.btgmobilechallenge.commons.Utils.valorMonetarioParaDouble
import br.com.cauejannini.btgmobilechallenge.commons.form.validators.Validations.validarValorMonetario

/**
 * Created by cauejannini on 14/03/2018.
 */
class ValorMonetarioValidator : Validator {

    var min: Double? = null
    var max: Double? = null

    constructor() {}

    constructor(min: Double?, max: Double?) {
        this.min = min
        this.max = max
    }

    override fun validate(text: String?): ValidationResult? {

        val validationResult = validarValorMonetario(text!!)
        if (validationResult.isValid) {
            if (min != null || max != null) {

                if (min != null && max != null && min!! > max!!) {
                    return ValidationResult(false, "Valor inválido")
                }

                val valorDouble = valorMonetarioParaDouble(text)

                if (valorDouble != null) {
                    if (min != null && valorDouble < min!!) {
                        return ValidationResult(false, "O valor mínimo é de " + doisDecimais(min))
                    }

                    return if (max != null && valorDouble > max!!) {
                        ValidationResult(false, "O valor máximo é de " + doisDecimais(max))
                    } else ValidationResult(true, "Válido")
                }
            }
        }
        return validationResult
    }
}