package com.btgpactual.teste.mobile_challenge.data.remote.sync

import android.util.Log
import androidx.lifecycle.MutableLiveData
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyValueEntity
import com.btgpactual.teste.mobile_challenge.data.local.repository.CurrencyValueRepository
import com.btgpactual.teste.mobile_challenge.data.preferences.PreferencesData
import com.btgpactual.teste.mobile_challenge.data.remote.Response
import com.btgpactual.teste.mobile_challenge.data.remote.SyncApi
import com.btgpactual.teste.mobile_challenge.data.remote.dto.CurrencyValue
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.lang.Exception
import java.text.SimpleDateFormat
import java.util.*
import javax.inject.Inject
import javax.inject.Singleton
import kotlin.jvm.Throws
import kotlin.system.measureTimeMillis

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Singleton
class SyncCurrencyValue @Inject constructor(
    private val api: SyncApi,
    private val currencyValueRepository: CurrencyValueRepository
) {

    @Inject
    lateinit var preferences: PreferencesData

    private val mtbCurrencyValue = MutableLiveData<Response<Int>>()

    fun getResult() : MutableLiveData<Response<Int>> {
        return mtbCurrencyValue
    }
    
    suspend fun sync() {
        try {
            Log.d(TAG, "sync: Values")
            mtbCurrencyValue.postValue(Response.Loading(null))
            val timeSyncAll = measureTimeMillis { 
                val resCurrencyValue = getCurrencyValue()
                if (resCurrencyValue?.timestamp != null) {
                    val lastSyncDate = Date(resCurrencyValue.timestamp * 1000)
                    val dateFormat = SimpleDateFormat("dd/MM/yyyy HH:mm:ss")
                    preferences.setLastUpdate(dateFormat.format(lastSyncDate))
                }
                currencyValuetoDB(resCurrencyValue!!)
            }
            Log.d(TAG, "sync: Time syncing ${(timeSyncAll/1000)}")
        } catch (exception: Exception) {
            mtbCurrencyValue.postValue(Response.Error(exception.toString(), -1))
        }
    }

    @Throws(Exception::class)
    private suspend fun currencyValuetoDB(currencyValue: CurrencyValue) {
        withContext(Dispatchers.IO) {
            val timeSave = measureTimeMillis {
                Log.d(TAG, "currencyValuetoDB: " + currencyValue.toString())
                val listCurrencyValue: List<CurrencyValueEntity> = currencyValue.quotes.map {
                    CurrencyValueEntity(it.key, it.value)
                }
                currencyValueRepository.insertAll(listCurrencyValue)
            }
            Log.d(TAG, "currencyValuetoDB: Time converting to DB ${(timeSave/1000)}")
        }
        mtbCurrencyValue.postValue(Response.Success(0))
    }

    @Throws(Exception::class)
    private suspend fun getCurrencyValue(): CurrencyValue? {
        var currencyValue: CurrencyValue? = null
        withContext(Dispatchers.IO) {
            val timeSync = measureTimeMillis {
                currencyValue = api.getLiveCurrencies()
            }
            Log.d(TAG, "getCurrencyValue: Time consulting api values ${(timeSync/1000)}")
        }
        return currencyValue
    }

    companion object {
        private const val TAG = "SyncCurrencyValue"
    }
}