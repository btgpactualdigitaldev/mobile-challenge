package br.com.cauejannini.btgmobilechallenge.commons.form.validators

/**
 * Created by cauejannini on 23/02/17.
 */
object Validations {

    fun validarValorMonetario(renda: String): ValidationResult {

        val rendaJustNumbers = renda.replace(".", "").replace("R$", "").trim { it <= ' ' }
        val arrayRenda = rendaJustNumbers.split(",".toRegex()).toTypedArray()
        val rendaSemDecimal = arrayRenda[0]

        return if (rendaSemDecimal.matches("[0-9]+".toRegex())) {
            ValidationResult(true, "Valor ok")
        } else {
            ValidationResult(false, "Valor inválido")
        }
    }
}