package com.helano.converter.ui.splash

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.helano.repository.CurrencyRepository
import com.helano.shared.Constants
import com.helano.shared.enums.Error
import com.helano.shared.model.Result
import com.helano.shared.util.Preferences
import com.helano.shared.util.network.ConnectivityStateHolder
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import java.util.concurrent.TimeUnit

class SplashViewModel @ViewModelInject constructor(
    private val repository: CurrencyRepository,
    private val prefs: Preferences
) : ViewModel() {

    val refreshResult by lazy { MutableLiveData<Result>() }

    fun start() {
        viewModelScope.launch {
            refreshData()
        }
    }

    private suspend fun refreshData() {
        val lastDataUpdate = prefs.lastDataUpdate
        val currentTime = System.currentTimeMillis()
        val result: Result

        if (currentTime - lastDataUpdate > TimeUnit.HOURS.toMillis(Constants.TIMEOUT_TO_REFRESH)
            && ConnectivityStateHolder.isConnected
        ) {
            val lastUpdate = repository.refreshData()
            if (lastUpdate != null) {
                prefs.lastUpdate = lastUpdate
                prefs.lastDataUpdate = System.currentTimeMillis()
                result = Result(true)
            } else {
                result = Result(false, Error.SERVER)
            }
        } else if (lastDataUpdate != Constants.NO_DATA) {
            result = Result(true)
        } else {
            result = Result(false, Error.CONNECTION)
        }

        val timeLapsed = System.currentTimeMillis() - currentTime
        if (timeLapsed < Constants.TIMEOUT_SPLASH) {
            delay(Constants.TIMEOUT_SPLASH - timeLapsed)
            refreshResult.value = result
        } else {
            refreshResult.value = result
        }
    }
}