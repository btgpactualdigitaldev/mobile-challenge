package com.mbarros64.btg_challenge.repository

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.mbarros64.btg_challenge.database.dao.CurrencyDao
import com.mbarros64.btg_challenge.database.entity.Currency
import com.mbarros64.btg_challenge.network.service.CurrencyList
import com.mbarros64.btg_challenge.network.service.CurrencyRate
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

class HomeRepository(
    private val localData: CurrencyDao,
    private val remoteCurrencyRate: CurrencyRate,
    private val remoteCurrencyList: CurrencyList
) {

    suspend fun getExchangeRateValues(): LiveData<List<Currency>> {
        try {
            val list: MutableLiveData<List<Currency>> = MutableLiveData()

            getCurrencyRemoteResources()
            list.value = getLocalCurrencies()

            return list
        } catch (e: Throwable) {
            throw Exception(e)
        }
    }

    private suspend fun getLocalCurrencies(): List<Currency> {
        try {
            return localData.getAllCurrencies()
        } catch (e: Throwable) {
            throw Exception(e)
        }
    }


    private suspend fun getCurrencyRemoteResources() {
        try {
            val quotesLiveResponse = remoteCurrencyRate.getCurrencyLive()
            val currencyNameResponse = remoteCurrencyList.getCurrencyList()

            if (quotesLiveResponse.isSuccessful) {
                if (quotesLiveResponse.body()?.success == true && currencyNameResponse.body()?.success == true) {
                    val currencyList: MutableList<Currency> = mutableListOf()

                    val quotes = quotesLiveResponse.body()?.quotes
                    val currenciesNameList = currencyNameResponse.body()?.currencies

                    val quotesKeys: MutableList<String> = mutableListOf()


                    quotes?.let {
                        quotesKeys.addAll(it.keys.toList())

                        for (key in quotesKeys) {
                            val currencyInitials = key.substring(key.length / 2)

                            val currency =
                                Currency(
                                    currency = currencyInitials,
                                    currencyName = currenciesNameList!![currencyInitials]!!,
                                    rate = it[key]!!
                                )

                            currencyList.add(currency)
                        }

                        updateLocalDatabase(currencies = currencyList)
                    } ?: throw Exception("Empty List")
                }
            }
        } catch (e: Throwable) {
            throw Exception(e)
        }
    }

    private suspend fun updateLocalDatabase(currencies: List<Currency>) {
        try {
            localData.updateAllRate(currencies)
        } catch (e: Exception) {
            throw Exception(e)
        }
    }
}