package com.example.currencyconverter.ui.converter

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.currencyconverter.database.CurrencyModel
import com.example.currencyconverter.repository.ConverterRepository
import kotlinx.coroutines.launch
import java.lang.Exception

class ConverterViewModel(private val converterRepository: ConverterRepository) : ViewModel() {

    private val mConverterList: MutableLiveData<List<CurrencyModel>> = MutableLiveData()
    val converterList: LiveData<List<CurrencyModel>> = mConverterList

    private val mErrorValue: MutableLiveData<String> = MutableLiveData()
    val errorValue: LiveData<String> = mErrorValue

    fun getList(){
        try {
            viewModelScope.launch {
                mConverterList.value = converterRepository.getList()
            }
        } catch (e: Exception){
            mErrorValue.value = e.message
        }
    }

     fun getListFromApi(){
        try {
            viewModelScope.launch {
                mConverterList.value = converterRepository.getListFromApi()
            }
        } catch (e: Throwable){
            mErrorValue.value = e.message
        }
    }
}