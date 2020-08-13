package com.curymorais.moneyconversion.currencyConversion

import android.util.Log
import androidx.lifecycle.*
import com.curymorais.moneyconversion.data.CurrencyRepository
import com.curymorais.moneyconversion.data.remote.model.CurrencyListResponse
import com.curymorais.moneyconversion.data.remote.model.CurrencyPriceResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class ConversionFragmentViewModel(coin : String) : ViewModel(){
    private val repository: CurrencyRepository = CurrencyRepository()

    val result = liveData(Dispatchers.IO) {
        val retrivedTodo = repository.getUSDValue(coin)
        emit(retrivedTodo)
    }

}