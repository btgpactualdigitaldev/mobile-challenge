package com.br.mobilechallenge.viewmodel

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

class ViewModelQuotes : ViewModel(), ListMap {

    val errorMessageQuotes = MutableLiveData<String>()

    var currencyQuotes = MutableLiveData<ArrayList<MappingObject>>()
    private val repository = Repository()

//    fun getCurrencyQuotes() = CoroutineScope(Dispatchers.IO).launch {
//        repository.getQuoteService().let { it -> currencyQuotes.postValue(mapToQuoteList(it.quotes))
//        }
//    }

    fun getCurrencyQuotes() = CoroutineScope(Dispatchers.IO)
        .launch {
            try {
                repository.getQuoteService().let { it ->
                    currencyQuotes.postValue(mapToQuoteList(it.quotes))
                }
            } catch (error: Throwable) {

                handleError(error)
            }
        }

    private fun handleError(error: Throwable) {
        when (error) {

            is HttpException -> errorMessageQuotes.postValue(
                "Erro de conexão:  " +
                        "${error.code()}"
            )
            is UnknownHostException -> errorMessageQuotes.postValue(
                "Verifique sua " +
                        "conexão"
            )
        }
    }
}