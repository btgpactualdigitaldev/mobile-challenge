package com.example.currencyconverter.repository

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.currencyconverter.database.CurrencyDao
import com.example.currencyconverter.database.CurrencyModel
import com.example.currencyconverter.remote.CurrencyList
import com.example.currencyconverter.remote.Rate

class ConverterRepository(
    private val currencyDao: CurrencyDao,
    private val currencyApi: CurrencyList,
    private val rateApi: Rate
) {
     suspend fun getListFromApi(): List<CurrencyModel> {
         val currencyList: MutableList<CurrencyModel> = mutableListOf()
        try {
            val currenciesNameResponse = currencyApi.getCurrencyList()
            val currenciesRateResponse = rateApi.getRateList()

            if (currenciesNameResponse.body()?.success == true && currenciesRateResponse.body()?.success == true){

                val currenciesRate = currenciesRateResponse.body()?.mapRates
                val currenciesName = currenciesNameResponse.body()?.mapCurrencies

                val currenciesRateKeys: MutableList<String> = mutableListOf()

                currenciesRate?.let { keys ->
                    currenciesRateKeys.addAll(keys.keys.toList())

                    currenciesRateKeys.forEach{ key ->
                        val initialLetters = key.substring(key.length - 3)

                        val currency = CurrencyModel(
                            currency = initialLetters,
                            rate = keys[key]!!,
                            currencyName = currenciesName!![initialLetters]!!
                        )

                        currencyList.add(currency)
                    }
                    insertOfflineCurrencies(currencies = currencyList)
                }
            }
        }catch (e: Throwable) {
            throw Exception(e)
        }
         return currencyList
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