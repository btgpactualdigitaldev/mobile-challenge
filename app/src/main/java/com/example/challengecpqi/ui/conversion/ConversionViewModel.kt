package com.example.challengecpqi.ui.conversion

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.challengecpqi.model.response.QuotesResponse
import com.example.challengecpqi.network.config.Result
import com.example.challengecpqi.dao.config.ResultLocal
import com.example.challengecpqi.repository.QuotesRepository
import kotlinx.coroutines.launch

class ConversionViewModel(val repository: QuotesRepository) : ViewModel() {

    val errorMsg = MutableLiveData<String>()
    val responseQuotes = MutableLiveData<QuotesResponse>()

    fun call() {
        viewModelScope.launch {
            when (val response = repository.getListQuotes()) {
                is Result.NetworkError -> getDataLocal()
                is Result.GenericError-> if (response.errorResponse?.error?.code == 104) {
                    getDataLocal()
                } else {
                    errorMsg.value = response.errorResponse?.error?.info!!
                }
                is Result.Success -> responseQuotes.value = response.value
            }
        }
    }

    fun getData() {
        viewModelScope.launch {
            getDataLocal()
        }
    }

    private suspend fun getDataLocal() {
        when(val data = repository.getListQuoteLocal()) {
            is ResultLocal.Success -> {
                responseQuotes.value = data.value
            }
            is ResultLocal.Error -> {
                errorMsg.value = data.errorMsg
            }
        }
    }

}