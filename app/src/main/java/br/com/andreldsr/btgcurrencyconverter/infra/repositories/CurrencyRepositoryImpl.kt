package br.com.andreldsr.btgcurrencyconverter.infra.repositories

import br.com.andreldsr.btgcurrencyconverter.data.datasources.CurrencyDatasourceImpl
import br.com.andreldsr.btgcurrencyconverter.data.db.AppDatabase
import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency
import br.com.andreldsr.btgcurrencyconverter.domain.repositories.CurrencyRepository
import br.com.andreldsr.btgcurrencyconverter.infra.datasources.CurrencyDatasource
import br.com.andreldsr.btgcurrencyconverter.infra.services.ApiService
import br.com.andreldsr.btgcurrencyconverter.infra.services.CurrencyService
import br.com.andreldsr.btgcurrencyconverter.util.ConnectionUtil
import br.com.andreldsr.btgcurrencyconverter.util.ConnectionUtil.context
import retrofit2.awaitResponse

class CurrencyRepositoryImpl(private val currencyService: CurrencyService, private val currencyDatasource: CurrencyDatasource?) : CurrencyRepository {
    override suspend fun getCurrency(): List<Currency> {
        val currencies = mutableListOf<Currency>()
        if(ConnectionUtil.isNetworkConnected()){
            loadCurrenciesFromAPI(currencies)
        } else {
            loadCurrenciesFromDB(currencies)
        }
        return currencies
    }

    override suspend fun getQuote(from: String, to: String): Float {
        var quote = 0f
        if(ConnectionUtil.isNetworkConnected()) {
            quote = getQuoteFromAPI(from, to)
        } else {
            quote = getQuoteFromDB(from, to)
        }
        quote == 0f ?: throw Exception()
        return quote
    }

    override suspend fun getQuoteList(): Map<String, String> {
        val response = currencyService.getQuote().awaitResponse()
        if (!response.isSuccessful)
            throw Exception()
        val quoteMap = response.body()?.quotes
        quoteMap ?: throw Exception()
        return quoteMap
    }

    private suspend fun loadCurrenciesFromAPI(currencyList: MutableList<Currency>){
        val response = currencyService.getCurrency().awaitResponse()
        if (!response.isSuccessful) {
            throw Exception()
        }
        val currenciesMap = response.body()?.currencies
        currenciesMap?.map {
            currencyList.add(Currency(initials = it.key, name = it.value))
        }
    }

    private suspend fun loadCurrenciesFromDB(currencies: MutableList<Currency>) {
        currencyDatasource?.getCurrencies()?.map {
            currency -> currencies.add(currency)
        }
    }

    private suspend fun getQuoteFromAPI(from: String, to: String): Float {
        val response = currencyService.getQuote().awaitResponse()
        if (!response.isSuccessful)
            throw Exception()
        val quoteMap = response.body()?.quotes
        val quoteFrom = quoteMap?.get("${baseQuoteName}$from")?.toFloat() ?: throw Exception()
        val quoteTo = quoteMap["${baseQuoteName}$to"]?.toFloat() ?: throw Exception()
        return  quoteTo / quoteFrom
    }

    private suspend fun getQuoteFromDB(from: String, to: String): Float {

        val quoteFrom = currencyDatasource?.getQuote(from)
        val quoteTo = currencyDatasource?.getQuote(to)
        if (quoteTo != null) {
            return quoteTo / quoteFrom!!
        }

        return 0f
    }

    companion object {
        private const val baseQuoteName = "USD"
        fun build(): CurrencyRepositoryImpl {
            val datasource = CurrencyDatasourceImpl(AppDatabase.getInstance(context).currencyDao)
            return CurrencyRepositoryImpl(ApiService.service, datasource)
        }
    }
}