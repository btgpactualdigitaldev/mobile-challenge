package com.geocdias.convecurrency.repository

import androidx.lifecycle.LiveData
import androidx.lifecycle.map
import com.geocdias.convecurrency.data.database.dao.CurrencyDao
import com.geocdias.convecurrency.data.database.dao.ExchangeRateDao
import com.geocdias.convecurrency.data.network.CurrencyClient
import com.geocdias.convecurrency.data.network.response.performFetchOperation
import com.geocdias.convecurrency.model.CurrencyModel
import com.geocdias.convecurrency.model.ExchangeRateModel
import com.geocdias.convecurrency.util.Constants
import com.geocdias.convecurrency.util.CurrencyMapper
import com.geocdias.convecurrency.util.Resource
import javax.inject.Inject

class CurrencyRepositoryImpl @Inject constructor(
    val currencyDao: CurrencyDao,
    val exchangeRateDao: ExchangeRateDao,
    val currencyClient: CurrencyClient,
    val mapper: CurrencyMapper
) : CurrencyRepository {

    override fun fetchCurrencies(): LiveData<Resource<List<CurrencyModel>>> {
        return performFetchOperation(
            databaseQuery = { fetchCurrenciesFromDb() },
            networkCall = { currencyClient.fetchCurrencies(Constants.KEY) },
            saveCallResult = { currencyListRespose ->
                val currencies =  mapper.remoteCurrencyListToDbMapper.map(currencyListRespose)
                currencyDao.insertCurrencyList(currencies)
            }
        )
    }

    private fun fetchCurrenciesFromDb() = currencyDao.observeCurrencyList().map {
        mapper.currencyEntityToDomainMapper.mapList(it)
    }

    override fun getRate(fromCurrency: String, toCurrency: String ): LiveData<Resource<ExchangeRateModel>> {
        return performFetchOperation(
            databaseQuery = { fetchCurrencyRateFromDb(fromCurrency, toCurrency) },
            networkCall = { currencyClient.fetchRates(Constants.KEY) },
            saveCallResult = { exchangeRateRespose ->
                val exchangeRates =  mapper.remoteExchangeRateToDbMapper.map(exchangeRateRespose)
                exchangeRateDao.insertExchangeRate(exchangeRates)
            }
        )
    }

    fun fetchCurrencyRateFromDb(fromCurrency: String, toCurrency: String): LiveData<ExchangeRateModel> {
        val quote = "$fromCurrency$toCurrency"

        return exchangeRateDao.getRate(quote).map {
            mapper.exchangeRateEntityToModel.map(it)
        }
    }

    override suspend fun getCurrencyByCode(code: String): LiveData<Resource<CurrencyModel>> {
        TODO("Not yet implemented")
    }

    override suspend fun getCurrencyByName(name: String): LiveData<Resource<List<CurrencyModel>>> {
        TODO("Not yet implemented")
    }

    override suspend fun getAllCurrencyCodes(): LiveData<Resource<List<String>>> {
        TODO("Not yet implemented")
    }
}
