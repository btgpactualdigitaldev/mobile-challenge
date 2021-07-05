package com.example.currencyconverter.ui.currencyList

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.currencyconverter.database.CurrencyModel
import com.example.currencyconverter.repository.CurrencyListRepository
import kotlinx.coroutines.launch
import java.lang.Exception

class CurrencyListViewModel(private val listRepository: CurrencyListRepository) : ViewModel() {

    private val mListOfCurrencies: MutableLiveData<List<CurrencyModel>> = MutableLiveData()
    val listOfCurrencies: LiveData<List<CurrencyModel>> = mListOfCurrencies


    fun getList(){
        try {
            viewModelScope.launch {
                mListOfCurrencies.value = listRepository.getList()
            }
        } catch (e: Exception){
            Throwable(e)
        }
    }

    fun getListFromApi(){
        try {
            viewModelScope.launch {
                mListOfCurrencies.value = listRepository.getListFromApi()
            }
        } catch (e: Exception){
            Throwable(e)
        }
    }
}