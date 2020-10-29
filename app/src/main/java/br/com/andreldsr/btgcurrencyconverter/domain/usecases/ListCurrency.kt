package br.com.andreldsr.btgcurrencyconverter.domain.usecases
import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency
import br.com.andreldsr.btgcurrencyconverter.domain.repositories.CurrencyRepository

interface ListCurrency {
    suspend fun getList(): List<Currency>
}

class ListCurrencyImpl(private val currencyRepository: CurrencyRepository) : ListCurrency{
    override suspend fun getList(): List<Currency> {
        return currencyRepository.getCurrency()
    }

}