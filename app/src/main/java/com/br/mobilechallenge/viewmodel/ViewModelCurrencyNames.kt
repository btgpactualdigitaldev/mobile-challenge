package com.br.mobilechallenge.viewmodel

import android.content.Context
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.br.mobilechallenge.helper.ListMap
import com.br.mobilechallenge.model.MappingObject
import com.br.mobilechallenge.repository.Repository
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import retrofit2.HttpException
import java.net.UnknownHostException

class ViewModelCurrencyNames : ViewModel(), ListMap {

    val errorMessageList = MutableLiveData<String>()

    var currencyNames = MutableLiveData<ArrayList<MappingObject>>()
    private val repository = Repository()

//    fun getCurrencyNames() = CoroutineScope(Dispatchers.IO).launch {
//        repository.getCurrencyList().let { it -> currencyNames.postValue(mapToList(it.currencies))
//        }
//    }

    fun getCurrencyNames() = CoroutineScope(Dispatchers.IO)
        .launch {
            try {
                repository.getCurrencyList().let { it ->
                    currencyNames.postValue(mapToList(it.currencies))
                }

            } catch (error: Throwable) {

                handleError(error)
            }
        }

    private fun handleError(error: Throwable) {
        when (error) {

            is HttpException -> errorMessageList.postValue(
                "Erro de conexão:  " +
                        "${error.code()}"
            )
            is UnknownHostException -> errorMessageList.postValue(
                "Verifique sua " +
                        "conexão"
            )
        }
    }

}