package com.btgpactual.currencyconverter.ui.viewmodel

import android.util.Log
import androidx.lifecycle.*
import com.btgpactual.currencyconverter.data.repository.CurrencyExternalRepository
import kotlinx.coroutines.*
import com.btgpactual.currencyconverter.R
import com.btgpactual.currencyconverter.data.framework.retrofit.NetworkConnectionInterceptor
import com.btgpactual.currencyconverter.data.model.CurrencyModel
import com.btgpactual.currencyconverter.data.repository.CurrencyInternalRepository
import com.btgpactual.currencyconverter.util.NoInternetException

class OpeningViewModel(private val currencyExternalRepository: CurrencyExternalRepository, private val currencyInternalRepository: CurrencyInternalRepository) : ViewModel() {

    private val _currencyModelListStateEventData = MutableLiveData<CurrencyModelListState>()

    val currencyModelListStateEventData: LiveData<CurrencyModelListState>
        get() = _currencyModelListStateEventData

    fun updateCurrencyModelList(networkConnectionInterceptor: NetworkConnectionInterceptor) = viewModelScope.launch(Dispatchers.IO) {

        val currencyListCount = currencyInternalRepository.getCount()

        val existentList = currencyListCount>0

        try {
            currencyExternalRepository.getCurrencyModelList(networkConnectionInterceptor){ result: CurrencyExternalRepository.CurrencyModelListResult ->
                when (result) {
                    is CurrencyExternalRepository.CurrencyModelListResult.RequestSuccess -> {

                        viewModelScope.launch(Dispatchers.IO) {
                            currencyInternalRepository.deleteAll()
                                .also { currencyInternalRepository.insertAll(result.listCurrencyModel) }
                            _currencyModelListStateEventData.postValue(
                                CurrencyModelListState.SuccessfulUpdate
                            )
                        }
                    }

                    is CurrencyExternalRepository.CurrencyModelListResult.RequestError -> {
                        _currencyModelListStateEventData.postValue(
                            CurrencyModelListState.FailedUpdate.FailedRequest(
                                existentList
                            )
                        )
                    }
                    is CurrencyExternalRepository.CurrencyModelListResult.UnhandledError -> {
                        _currencyModelListStateEventData.postValue(
                            CurrencyModelListState.FailedUpdate.FailedRequest(
                                existentList
                            )
                        )
                    }
                }
            }
        } catch (e: NoInternetException) {
            _currencyModelListStateEventData.postValue(
                CurrencyModelListState.FailedUpdate.NoInternetConnection(
                    existentList
                )
            )
        }

    }
    class ViewModelFactory(private val currencyExternalRepository: CurrencyExternalRepository,private val currencyInternalRepository: CurrencyInternalRepository) : ViewModelProvider.Factory {
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {

            if (modelClass.isAssignableFrom(OpeningViewModel::class.java)) {
                return OpeningViewModel(
                    currencyExternalRepository,
                    currencyInternalRepository
                ) as T
            }

            throw IllegalArgumentException("Unknown ViewModel class")
        }
    }

    sealed class CurrencyModelListState {

        object SuccessfulUpdate : CurrencyModelListState()

        sealed class FailedUpdate : CurrencyModelListState() {
            class NoInternetConnection( val existentList : Boolean) : FailedUpdate()
            class FailedRequest( val existentList : Boolean) : FailedUpdate()
        }

    }
}