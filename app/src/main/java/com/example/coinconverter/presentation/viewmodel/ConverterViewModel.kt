package com.example.coinconverter.presentation.viewmodel

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MediatorLiveData
import androidx.lifecycle.viewModelScope
import com.example.coinconverter.data.remote.network.RetrofitInitializer
import com.example.coinconverter.data.remote.service.ConvertService
import com.example.coinconverter.domain.model.Quote
import kotlinx.coroutines.launch

class ConverterViewModel(application: Application) : AndroidViewModel(application) {

    private val convertService: ConvertService

    val quote = MediatorLiveData<List<Quote>>()

    init {
        convertService = RetrofitInitializer().ConvertService()
        loadQuotes()
    }

    fun loadQuotes() = viewModelScope.launch {
        val map = convertService.getLive().quotes.toList().map {
            Quote(coin = it.first, value = it.second)
        }
        quote.postValue(map)
    }
}