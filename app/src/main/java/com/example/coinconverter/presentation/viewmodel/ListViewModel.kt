package com.example.coinconverter.presentation.viewmodel

import android.app.Application
import android.util.Log
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MediatorLiveData
import androidx.lifecycle.viewModelScope
import com.example.coinconverter.data.remote.network.RetrofitInitializer
import com.example.coinconverter.data.remote.service.ConvertService
import com.example.coinconverter.domain.model.Currencie
import kotlinx.coroutines.launch

class ListViewModel(application: Application) : AndroidViewModel(application) {

    private val convertService: ConvertService

    val currencies = MediatorLiveData<List<Currencie>>()

    init {
        convertService = RetrofitInitializer().ConvertService()
        loadCurriencesList()
    }

    fun loadCurriencesList() = viewModelScope.launch {
        val map = convertService.listCurrencie().currencies.toList().map {
            Currencie(key = it.first, value = it.second)
        }
        currencies.postValue(map)
    }
}