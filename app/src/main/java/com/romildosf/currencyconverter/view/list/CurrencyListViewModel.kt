package com.romildosf.currencyconverter.view.list

import androidx.lifecycle.ViewModel
import androidx.lifecycle.liveData
import com.romildosf.currencyconverter.repository.CurrencyRepository
import kotlinx.coroutines.Dispatchers

class CurrencyListViewModel(private val currencyRepository: CurrencyRepository): ViewModel() {
    private val scope = Dispatchers.Default

    fun fetchCurrencyList() = liveData(scope) {
        emit(currencyRepository.fetchCurrencyList())
    }

}