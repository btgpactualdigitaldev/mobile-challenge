package com.btgpactual.teste.mobile_challenge.data.remote.sync

import android.util.Log
import androidx.lifecycle.MutableLiveData
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyEntity
import com.btgpactual.teste.mobile_challenge.data.local.repository.CurrencyRepository
import com.btgpactual.teste.mobile_challenge.data.remote.Response
import com.btgpactual.teste.mobile_challenge.data.remote.SyncApi
import com.btgpactual.teste.mobile_challenge.data.remote.dto.CurrencyList
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.lang.Exception
import javax.inject.Inject
import javax.inject.Singleton
import kotlin.jvm.Throws
import kotlin.system.measureTimeMillis

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Singleton
class SyncCurrencyList @Inject constructor(
    private val api: SyncApi,
    private val currencyRepository: CurrencyRepository
) {

    private val mtbCurrencyList = MutableLiveData<Response<Int>>()

    fun getResult() : MutableLiveData<Response<Int>> {
        return mtbCurrencyList
    }
    
    suspend fun sync() {
        try {
            Log.d(TAG, "sync: List")
            mtbCurrencyList.postValue(Response.Loading(null))
            val timeSyncAll = measureTimeMillis { 
                val resCurrencyList = getCurrencyList()
                currencyListtoDB(resCurrencyList!!)
            }
            Log.d(TAG, "sync: Time syncing ${(timeSyncAll/1000)}")
        } catch (exception: Exception) {
            mtbCurrencyList.postValue(Response.Error(exception.toString(), -1))
        }
    }

    @Throws(Exception::class)
    private suspend fun currencyListtoDB(currencyList: CurrencyList) {
        withContext(Dispatchers.IO) {
            val timeSave = measureTimeMillis {
                Log.d(TAG, "currencyListtoDB: $currencyList")
                val listCurrencyEntity: List<CurrencyEntity> = currencyList.currencies.map {
                    CurrencyEntity(it.key, it.value)
                }
                currencyRepository.insertAll(listCurrencyEntity)
            }
            Log.d(TAG, "currencyListtoDB: Time converting to DB ${(timeSave/1000)}")
        }
        mtbCurrencyList.postValue(Response.Success(0))
    }

    @Throws(Exception::class)
    private suspend fun getCurrencyList(): CurrencyList? {
        var currencyList: CurrencyList? = null
        withContext(Dispatchers.IO) {
            val timeSync = measureTimeMillis {
                currencyList = api.getListCurrencies()
            }
            Log.d(TAG, "getCurrencyList: Time consulting api list ${(timeSync/1000)}")
        }
        return currencyList
    }

    companion object {
        private const val TAG = "SyncCurrencyList"
    }
}