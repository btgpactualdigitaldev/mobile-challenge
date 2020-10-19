package com.btgpactual.teste.mobile_challenge.ui.main

import android.util.Log
import androidx.lifecycle.MediatorLiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyEntity
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyValueEntity
import com.btgpactual.teste.mobile_challenge.data.local.repository.CurrencyRepository
import com.btgpactual.teste.mobile_challenge.data.local.repository.CurrencyValueRepository
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Dispatchers.IO
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import javax.inject.Inject

/**
 * Created by Carlos Souza on 17,October,2020
 */
class MainViewModel @Inject constructor(
    private val currencyRepository: CurrencyRepository,
    private val currencyValueRepository: CurrencyValueRepository
): ViewModel() {

    val currencyOrigin = MutableLiveData<CurrencyEntity>()

    fun getCurrencyOrigin(cod: String) {
        CoroutineScope(IO).launch {
            currencyRepository.getById(cod).let {
                currencyOrigin.postValue(it)
            }
        }
    }

    val currencyTarget = MutableLiveData<CurrencyEntity>()

    fun getCurrencyTarget(cod: String) {
        CoroutineScope(IO).launch {
            currencyRepository.getById(cod).let {
                currencyTarget.postValue(it)
            }
        }
    }

    val currencyQuotation = MutableLiveData<CurrencyValueEntity>()

    fun getQuotation(cod: String) {
        CoroutineScope(IO).launch {
            currencyValueRepository.getByCurrency("USD$cod").let {
                currencyQuotation.postValue(it)
            }
        }
    }

    val originQuote = MutableLiveData<CurrencyValueEntity>()

    fun getOriginQuote(cod: String) {
        CoroutineScope(IO).launch {
            currencyValueRepository.getByCurrency("USD$cod").let {
                originQuote.postValue(it)
            }
        }
    }

    fun getCurrencyList() = currencyRepository.getAll()

}