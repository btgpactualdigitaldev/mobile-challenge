package com.geocdias.convecurrency.repository

import androidx.lifecycle.LiveData
import com.geocdias.convecurrency.data.database.entities.CurrencyEntity
import com.geocdias.convecurrency.data.database.entities.ExchangeRateEntity
import com.geocdias.convecurrency.model.CurrencyModel
import com.geocdias.convecurrency.model.ExchangeRateModel
import com.geocdias.convecurrency.util.Resource

interface CurrencyRepository {
    fun fetchCurrencies(): LiveData<Resource<List<CurrencyModel>>>
    fun getRate(fromCurrency: String, toCurrency: String): LiveData<Resource<ExchangeRateModel>>
    suspend fun getCurrencyByCode(code: String): LiveData<Resource<CurrencyModel>>
    suspend fun getCurrencyByName(name: String): LiveData<Resource<List<CurrencyModel>>>
    suspend fun getAllCurrencyCodes(): LiveData<Resource<List<String>>>
}
