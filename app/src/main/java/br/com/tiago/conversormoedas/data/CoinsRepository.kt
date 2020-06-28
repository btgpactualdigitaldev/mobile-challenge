package br.com.tiago.conversormoedas.data

interface CoinsRepository {
    fun getCoins(coinsResultsCallback: (result: CoinsResult) -> Unit)
    fun getCoinsDB(coinsResultsCallback: (result: CoinsResult) -> Unit)
}