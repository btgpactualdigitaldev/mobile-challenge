package com.geocdias.convecurrency.util

object CurrencyErrorHandler {
    fun handleError(code: Int): String {
        return when (code) {
            404 -> "O usuário solicitou um recurso que não existe."
            101 -> "Chave de acesso nao fornecido ou inválida."
            103 -> "O usuário solicitou uma função API inexistente."
            104 -> "User has reached or exceeded his subscription plan's monthly API request allowance."
            105 -> "O limite de solicitação mensal foi excedido."
            106 -> "A consulta não retornou nenhum resultado"
            102 -> "A conta do usuário não está ativa. O usuário será solicitado a entrar em contato com o Suporte ao cliente."
            201 -> "Moeda de origem inválida."
            202 -> "Um ou mais códigos da moeda são inválida."
            else -> "Ocorreu um erro inesperado."
        }
    }

    fun unknowHostError(): String {
        return "Não foi possível obter conexão online."
    }
}
