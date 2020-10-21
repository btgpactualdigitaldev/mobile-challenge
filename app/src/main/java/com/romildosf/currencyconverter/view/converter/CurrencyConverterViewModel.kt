package com.romildosf.currencyconverter.view.converter

import androidx.lifecycle.ViewModel
import androidx.lifecycle.liveData
import com.romildosf.currencyconverter.repository.CurrencyRepository
import kotlinx.coroutines.Dispatchers

class CurrencyConverterViewModel(private val currencyRepository: CurrencyRepository): ViewModel() {
    private val scope = Dispatchers.Default


    fun fetchCurrencyList() = liveData(scope) {
        emit(currencyRepository.fetchCurrencyList())
    }

    fun convert(source: String, target: String) = liveData(scope) {
        emit(currencyRepository.fetchCurrencyQuotation(source, target))
    }

}