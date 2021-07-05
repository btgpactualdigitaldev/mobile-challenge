package br.com.android.challengeandroid.usecase

import br.com.android.challengeandroid.model.CoinList
import br.com.android.challengeandroid.repository.CoinRepository

class CoinUseCase(private var repository: CoinRepository) {

    suspend fun getCoinList(coinSource: String): List<CoinList> {
        val result = repository.getCoinsList(coinSource)
        if (result.success) {
            val auxList = arrayListOf<CoinList>()
            for (key in result.currencies.keys) {
                result.currencies[key]?.let {
                    auxList.add(
                        CoinList(key, it)
                    )
                }
            }
            auxList.sortBy { it.name }
            return auxList
        } else {
            throw Exception("Erro api")
        }
    }

    suspend fun getPriceByCoin(source: String, destiny: String): Double {
        val result = repository.getPriceByCoin(source, destiny)
        if (result.success) {
            return result.quotes[source + destiny] ?: 0.0
        } else {
            throw Exception("Erro api")
        }
    }

    fun calculatesQuotation(source: Double, quote: Double): Double {
        return source * quote
    }

    fun currenciesAccepted(): List<String> {
        return listOf("USD")
    }
}
