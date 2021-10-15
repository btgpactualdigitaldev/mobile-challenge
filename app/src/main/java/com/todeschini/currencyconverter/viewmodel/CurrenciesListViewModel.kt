package com.todeschini.currencyconverter.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.todeschini.currencyconverter.data.repository.CurrenciesListRepository
import com.todeschini.currencyconverter.model.CurrencyName
import com.todeschini.currencyconverter.utils.convertMapToArrayListOfCurrencyName
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class CurrenciesListViewModel(
    private val repository: CurrenciesListRepository
): ViewModel() {

    val currencies = MutableLiveData<ArrayList<CurrencyName>>()
    val loading = MutableLiveData<Boolean>()
    val error = MutableLiveData<Boolean>()

    fun getAllCurrencies() {
        loading.value = true
        viewModelScope.launch(Dispatchers.IO) {
            val result = repository.getAllCurrencies()
            if(result.isSuccessful) {
                currencies.value = convertMapToArrayListOfCurrencyName(result.body()?.currencies)
                error.value = false
            } else {
                error.value = true
            }
            loading.value = false
        }
    }

}