package com.curymorais.moneyconversion.data

import android.util.Log
import com.curymorais.moneyconversion.data.remote.api.CurrencyListService
import com.curymorais.moneyconversion.data.remote.model.CurrencyListResponse
import com.curymorais.moneyconversion.data.remote.model.CurrencyPriceResponse
import com.curymorais.moneyconversion.util.RetrofitInitializer
import retrofit2.HttpException

class CurrencyRepository{

    private var currencyRepository: CurrencyListService = RetrofitInitializer().webservice

    suspend fun getCurrencyList() : CurrencyListResponse? {
        try {
            var currencyListResponse =  currencyRepository.getCurrencyList()
            Log.i("Cury", currencyListResponse.toString())
            return currencyListResponse
        }catch (he: HttpException) {
            Log.i("Cury", he.toString())
        }
        return null
    }

    suspend fun getUSDValue(coin: String) : CurrencyPriceResponse?  {

        try {
            var repos = currencyRepository.getUSDValue(coin)
            Log.i("Cury", repos.toString())
            return repos
        }catch (he: HttpException) {
            Log.i("Cury", he.toString())
        }
        return null

    }
}
