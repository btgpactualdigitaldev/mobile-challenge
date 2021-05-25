package com.vald3nir.btg_challenge.ui.splash

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.vald3nir.btg_challenge.core.base.BaseViewModel
import com.vald3nir.data.repository.DataRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class FullscreenViewModel(private val dataRepository: DataRepository) : BaseViewModel() {

    private val _flagLoadDatabaseCompleted = MutableLiveData<Unit>()
    val flagLoadDatabaseCompleted: LiveData<Unit> = _flagLoadDatabaseCompleted

    fun fillDatabase() {
        launch {
            withContext(Dispatchers.IO) {
                dataRepository.fillDatabase()
            }
            _flagLoadDatabaseCompleted.postValue(Unit)
        }
    }

}