package com.example.challengecpqi.repository

import android.content.Context
import com.example.challengecpqi.dao.config.CpqiDataBase
import com.example.challengecpqi.dao.entiry.CurrencyResponseWithCurrency
import com.example.challengecpqi.dao.entiry.toCurrency
import com.example.challengecpqi.model.Currency
import com.example.challengecpqi.model.response.CurrencyResponse
import com.example.challengecpqi.network.config.Result
import com.example.challengecpqi.dao.config.ResultLocal
import com.example.challengecpqi.dao.entiry.CurrencyEntity
import com.example.challengecpqi.dao.entiry.CurrencyResponseEntity
import com.example.challengecpqi.network.config.ServiceConfig
import com.example.challengecpqi.util.callLocal
import com.example.challengecpqi.util.callService
import com.google.gson.JsonObject
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import org.json.JSONObject

class CurrencyRepository(private val service: ServiceConfig,
                         private val context: Context,
                         private val dispatcher: CoroutineDispatcher = Dispatchers.IO) {

    private suspend fun getListCurrencyRemote(): Result<JsonObject> {
        return callService(dispatcher) { service.listCurrencyService?.getListCurrency()!! }
    }

    suspend fun getListCurrency() : Result<CurrencyResponse> {
         when (val response = getListCurrencyRemote()) {
            is Result.NetworkError -> return Result.NetworkError
            is Result.GenericError -> return Result.GenericError(response.errorResponse)
            is Result.Success -> {
                try {
                    val jsonObject = JSONObject(response.value.toString())
                    val success = jsonObject.getBoolean("success")
                    val terms = jsonObject.getString("terms")
                    val privacy = jsonObject.getString("privacy")
                    val currencies = mutableListOf<Currency>()
                    val jsonObjectCurrencies = jsonObject.getJSONObject("currencies")
                    val keys = jsonObjectCurrencies.keys()
                    while (keys.hasNext()) {
                        val key = keys.next() as String
                        currencies.add(
                            Currency(
                                key = key,
                                value = jsonObjectCurrencies.get(key).toString()
                            )
                        )
                    }
                    return Result.Success(CurrencyResponse(success, terms, privacy, currencies))
                } catch (e: Exception) {
                    return Result.NetworkError
                }
            }
        }
    }

    suspend fun saveCurrencyDB(value : CurrencyResponseEntity): ResultLocal<Unit> {
        return callLocal(dispatcher) { CpqiDataBase.invoke(context).currencyResponseDao().save(value) }
    }
    suspend fun saveListCurrencyDB(value : List<CurrencyEntity>): ResultLocal<Unit> {
        return callLocal(dispatcher) { CpqiDataBase.invoke(context).currencyDao().save(value) }
    }

     suspend fun getCurrencyResponseEntityDB(): ResultLocal<CurrencyResponseEntity?> {
        return callLocal(dispatcher) { CpqiDataBase.invoke(context).currencyResponseDao().getCurrencyResponse() }
    }

    private suspend fun getListCurrencyDB(): ResultLocal<CurrencyResponseWithCurrency?> {
        return callLocal(dispatcher) { CpqiDataBase.invoke(context).currencyResponseDao().allCurrencyResponse() }
    }

    private suspend fun getListCurrencyDB(value: String? = null): ResultLocal<List<CurrencyEntity>?> {
        return callLocal(dispatcher) { CpqiDataBase.invoke(context).currencyDao().getCurrency(value!!) }
    }

     suspend fun getListCurrencyLocal(value: String? = null) : ResultLocal<CurrencyResponse> {
           when(val data = getListCurrencyDB(value)) {
              is ResultLocal.Error -> return ResultLocal.Error(data.errorMsg)
              is ResultLocal.Success -> {
                 data.value?.also {
                     val currencies = mutableListOf<Currency>()
                     it.forEach { CurrencyEntity ->
                         currencies.add(CurrencyEntity.toCurrency())
                     }
                     return ResultLocal.Success(CurrencyResponse(
                         success = true,
                         privacy = "",
                         terms = "",
                         currencies = currencies
                     ))
                 }
                  return ResultLocal.Error(null)
             }
         }
    }

    suspend fun getListCurrencyLocal() : ResultLocal<CurrencyResponse> {
        when(val data = getListCurrencyDB()) {
            is ResultLocal.Error -> return ResultLocal.Error(data.errorMsg)
            is ResultLocal.Success -> {
                data.value?.also {
                    val currencies = mutableListOf<Currency>()
                    it.currencyEntities?.forEach { CurrencyEntity ->
                        currencies.add(CurrencyEntity.toCurrency())
                    }
                    return ResultLocal.Success(CurrencyResponse(
                        success = it.currencyResponseEntity.success,
                        privacy = it.currencyResponseEntity.privacy,
                        terms = it.currencyResponseEntity.terms,
                        currencies = currencies
                    ))
                }
                return ResultLocal.Error(null)
            }
        }
    }

}