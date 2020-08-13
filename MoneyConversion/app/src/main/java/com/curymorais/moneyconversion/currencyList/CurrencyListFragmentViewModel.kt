package com.curymorais.moneyconversion.currencyList

import androidx.lifecycle.ViewModel
import androidx.lifecycle.liveData
import com.curymorais.moneyconversion.data.CurrencyRepository
import kotlinx.coroutines.Dispatchers

class CurrencyListFragmentViewModel: ViewModel() {
    private val repository: CurrencyRepository = CurrencyRepository()

    val firstPage = liveData(Dispatchers.IO) {
        val retrivedTodo = repository.getCurrencyList()
        emit(retrivedTodo)
    }
}