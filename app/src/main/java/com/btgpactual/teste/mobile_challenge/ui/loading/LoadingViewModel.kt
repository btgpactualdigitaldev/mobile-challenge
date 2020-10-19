package com.btgpactual.teste.mobile_challenge.ui.loading

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.btgpactual.teste.mobile_challenge.data.local.datasource.CurrencyDataSource
import com.btgpactual.teste.mobile_challenge.data.local.datasource.CurrencyValueDataSource
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyEntity
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyValueEntity
import com.btgpactual.teste.mobile_challenge.data.local.repository.CurrencyRepository
import com.btgpactual.teste.mobile_challenge.data.local.repository.CurrencyValueRepository
import com.btgpactual.teste.mobile_challenge.data.remote.sync.SyncManager
import kotlinx.coroutines.launch
import javax.inject.Inject

/**
 * Created by Carlos Souza on 16,October,2020
 */
class LoadingViewModel @Inject constructor(
    private val syncManager: SyncManager,
    private val currencyRepository: CurrencyRepository
): ViewModel() {

    fun sync() {
        syncManager.syncAll()
    }

    fun observeSyncAll() = syncManager.getSyncCurrency()

    fun getCurrencyList() = currencyRepository.getAll()
}