package com.example.currencyconverter.repository

import com.example.currencyconverter.database.CurrencyDao
import com.example.currencyconverter.database.CurrencyModel
import com.example.currencyconverter.remote.CurrencyList
import com.example.currencyconverter.remote.Rate

class CurrencyListRepository(
    private val currencyDao: CurrencyDao,
    private val currencyApi: CurrencyList,
    private val rateApi: Rate
) {

   suspend fun getListFromApi():  List<CurrencyModel>{
       val currencyList: MutableList<CurrencyModel> = mutableListOf()
        try {
            val currenciesNameResponse = currencyApi.getCurrencyList()
            val currenciesRateResponse = rateApi.getRateList()

            if (currenciesNameResponse.body()?.success == true && currenciesRateResponse.body()?.success == true){

                val currenciesRate = currenciesRateResponse.body()?.mapRates
                val currenciesName = currenciesNameResponse.body()?.mapCurrencies

                val currenciesRateKeys: MutableList<String> = mutableListOf()

                currenciesRate?.let { rates ->
                    currenciesRateKeys.addAll(rates.keys.toList())

                    currenciesRateKeys.forEach{ key ->
                        val finalLetters = key.substring(key.length - 3)

                        val currency = CurrencyModel(
                            currency = finalLetters,
                            rate = rates[key]!!,
                            currencyName = currenciesName!![finalLetters]!!
                        )

                        currencyList.add(currency)
                    }
                    insertOfflineCurrencies(currencies = currencyList)

                }
            }
        }catch (e: Throwable) {
            throw Exception(e)
        }
       return  currencyList
    }

    private suspend fun insertOfflineCurrencies(currencies: List<CurrencyModel>){
        try {
            currencyDao.insertRates(currencies)
        }catch (e: Exception){
            throw Exception(e)
        }
    }

    suspend fun getList(): List<CurrencyModel>{
        try {
            return currencyDao.getAll()
        } catch (e: Throwable){
            throw java.lang.Exception(e)
        }
    }


}