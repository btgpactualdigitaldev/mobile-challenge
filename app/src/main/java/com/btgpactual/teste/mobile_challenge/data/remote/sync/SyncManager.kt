package com.btgpactual.teste.mobile_challenge.data.remote.sync

import android.util.Log
import androidx.lifecycle.MutableLiveData
import com.btgpactual.teste.mobile_challenge.data.remote.Response
import kotlinx.coroutines.*
import kotlinx.coroutines.Dispatchers.IO
import javax.inject.Inject
import javax.inject.Singleton
import kotlin.system.measureTimeMillis

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Singleton
class SyncManager @Inject constructor() {

    private val TAG = "SyncManager"

    @Inject
    lateinit var syncCurrencyList: SyncCurrencyList

    @Inject
    lateinit var syncCurrencyValue: SyncCurrencyValue

    private val syncCurrency = MutableLiveData<Response<Int>>()

    private val exceptionHandler = CoroutineExceptionHandler { _, exception ->
        syncCurrency.postValue(exception.message?.let { Response.Error(it, -1) })
    }

    fun syncAll() {
        CoroutineScope(IO).launch(exceptionHandler) {
            syncCurrency.postValue(Response.Loading(null))
            val timeSyncAll = measureTimeMillis {
                Log.d(TAG, "syncAll: start")
                val deferreds = listOf(
                    async { syncCurrencyList.sync() },
                    async { syncCurrencyValue.sync() }
                )

                deferreds.awaitAll()
                Log.d(TAG, "syncAll: end")
            }
            syncCurrency.postValue(Response.Success(0))
            Log.d(TAG, "syncAll: Time ${(timeSyncAll/1000)}")
        }
    }

    fun getSyncCurrency() = syncCurrency
}