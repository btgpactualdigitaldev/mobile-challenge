package br.com.leandrospidalieri.btgpactualconversion.repository

import androidx.lifecycle.LiveData
import androidx.lifecycle.Transformations
import br.com.leandrospidalieri.btgpactualconversion.database.CurrenciesDatabase
import br.com.leandrospidalieri.btgpactualconversion.database.asDomainCurrency
import br.com.leandrospidalieri.btgpactualconversion.domain.models.Currency
import br.com.leandrospidalieri.btgpactualconversion.network.Network
import br.com.leandrospidalieri.btgpactualconversion.network.toCurrencyDatabaseList
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class CurrencyRepository(private val database: CurrenciesDatabase){

    val currencies: LiveData<List<Currency>> = Transformations.map(
        database.currencyDao.getCurrencies()){
        it.asDomainCurrency()
    }

    suspend fun refreshCurrencies(){
        withContext(Dispatchers.IO){
            val currencies = Network.currencyApi.getCurrenciesAsync().await()
            val quotes = Network.currencyApi.getQuotesAsync().await()
            val currenciesWithQuotes = currencies.toCurrencyDatabaseList(quotes)
            database.currencyDao.insertAll(*currenciesWithQuotes)
        }
    }
}