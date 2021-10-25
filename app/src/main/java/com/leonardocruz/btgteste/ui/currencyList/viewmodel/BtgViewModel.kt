package com.leonardocruz.btgteste.ui.currencyList.viewmodel

import android.util.Log
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.leonardocruz.btgteste.model.Currencies
import com.leonardocruz.btgteste.repository.CurrencyRepository
import kotlinx.coroutines.*

class BtgViewModel(val repository : CurrencyRepository) : ViewModel() {
    private var job: Job? = null
    val errorMessage = MutableLiveData<String>()
    private val currencyList = MutableLiveData<HashMap<String, String>>()
    val currencyData = currencyList
    private val currencyLive = MutableLiveData<HashMap<String, String>>()
    val currencyLiveData = currencyLive
    private val exceptionHandler = CoroutineExceptionHandler { _, throwable ->
        onError("Exception handled: ${throwable.localizedMessage}")
    }

    fun getList(){
        job = CoroutineScope(Dispatchers.IO + exceptionHandler).launch {
            val response = repository.getList()
            withContext(Dispatchers.Main){
                if (response.isSuccessful) {
                    currencyList.value = response.body()?.currencies
                }
                else{
                    errorMessage.value = response.message()
                }
            }
        }
    }

    fun getLive(){
        job = CoroutineScope(Dispatchers.IO + exceptionHandler).launch {
            val response = repository.getLive()
            withContext(Dispatchers.Main){
                if(response.isSuccessful){
                    currencyLive.value = response.body()?.quotes
                }
                else{
                    Log.e("ERROR", response.message() )
                    errorMessage.value = response.message()
                }
            }
        }
    }

    fun searchCurrencies(newString: String, listCurrency: MutableList<Currencies>): MutableList<Currencies> {
        val tempList = mutableListOf<Currencies>()
        return if(newString.isNotEmpty()){
            listCurrency.forEach {
                if(it.initials.toUpperCase().contains(newString) || it.value.toUpperCase().contains(newString)){
                    tempList.add(it)
                }
            }
            tempList
        } else{
            listCurrency
        }
    }

    private fun onError(message: String) {
        errorMessage.postValue(message)
    }

    override fun onCleared() {
        super.onCleared()
        job?.cancel()
    }
}