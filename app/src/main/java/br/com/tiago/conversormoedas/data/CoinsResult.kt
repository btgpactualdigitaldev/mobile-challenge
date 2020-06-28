package br.com.tiago.conversormoedas.data

import br.com.tiago.conversormoedas.data.model.Coin

sealed class CoinsResult {
    class Success(val coins: List<Coin>) : CoinsResult()
    class ApiError(val statusCode: Int) : CoinsResult()
    object DBError: CoinsResult()
    object ServerError: CoinsResult()
}