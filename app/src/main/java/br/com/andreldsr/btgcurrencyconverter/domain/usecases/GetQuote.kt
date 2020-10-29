package br.com.andreldsr.btgcurrencyconverter.domain.usecases

import br.com.andreldsr.btgcurrencyconverter.domain.repositories.CurrencyRepository

interface GetQuote {
    suspend fun getQuote(from: String, to: String): Float
}

class GetQuoteFromUsdImpl(private val repository: CurrencyRepository) : GetQuote{
    override suspend fun getQuote(from: String, to: String): Float {
        if(from.length != 3 || to.length != 3){
           throw Exception()
        }
        return repository.getQuote(from, to)
    }

}