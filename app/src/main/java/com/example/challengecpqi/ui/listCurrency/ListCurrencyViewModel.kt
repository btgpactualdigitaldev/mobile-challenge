package com.example.challengecpqi.ui.listCurrency

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.challengecpqi.model.response.CurrencyResponse
import com.example.challengecpqi.network.config.Result
import com.example.challengecpqi.dao.config.ResultLocal
import com.example.challengecpqi.repository.CurrencyRepository
import kotlinx.coroutines.launch

class ListCurrencyViewModel(
    val repository: CurrencyRepository
) : ViewModel() {

    val responseCurrency = MutableLiveData<CurrencyResponse>()
    val errorMsg = MutableLiveData<String>()
    val listEmpty = MutableLiveData<Boolean>(false)
    val progress = MutableLiveData<Boolean>(true)

    fun call() {
        viewModelScope.launch {
            when (val response = repository.getListCurrency()) {
                is Result.NetworkError -> getDataLocal()
                is Result.GenericError-> {
                    if (response.errorResponse?.error?.code == 104) {
                        getDataLocal()
                    } else {
                        progress.value = (false)
                        listEmpty.value = (true)
                        errorMsg.value = response.errorResponse?.error?.info!!
                    }
                }
                is Result.Success -> {
                    progress.value = (false)
                    listEmpty.value = (false)
                    responseCurrency.value = response.value
                }
            }
        }
    }

    fun getSearchData(value: String? = null) {
        if (value.isNullOrEmpty()) {
            viewModelScope.launch {
                getDataLocal()
            }
        } else {
            viewModelScope.launch {
                getSearchDataLocal(value)
            }
        }
    }

    private suspend fun getDataLocal() {
         when(val data = repository.getListCurrencyLocal()) {
            is ResultLocal.Success -> {
                progress.value = (false)
                listEmpty.value = (false)
                responseCurrency.value = data.value
            }
            is ResultLocal.Error -> {
                progress.value = (false)
                listEmpty.value = (true)
            }
        }
    }

    private suspend fun getSearchDataLocal(value: String? = null) {
        when(val data = repository.getListCurrencyLocal("${value}%")) {
            is ResultLocal.Success -> {
                progress.value = (false)
                listEmpty.value = (false)
                responseCurrency.value = data.value
            }
            is ResultLocal.Error -> {
                progress.value = (false)
                listEmpty.value = (true)
            }
        }
    }
}