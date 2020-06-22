package com.br.btgteste.presentation.convert

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.domain.usecase.CurrencyLiveUseCase

class ConvertCurrencyViewModel(val currencyLiveUseCase: CurrencyLiveUseCase): ViewModel() {

    val liveDataResponse: MutableLiveData<ApiResult<Double>> = MutableLiveData()
    val currencyFrom: MutableLiveData<Currency> = MutableLiveData()
    val currencyTo: MutableLiveData<Currency> = MutableLiveData()

    fun convertCurrencyAmount(amount: Double) {

        val currencyFrom = currencyFrom.value
        val currencyTo = currencyTo.value

        if (currencyFrom != null && currencyTo != null) {
            currencyLiveUseCase(CurrencyLiveUseCase.Params(amount, currencyFrom, currencyTo)) {
                liveDataResponse.value = it
            }
        }
    }

    override fun onCleared() {
        super.onCleared()
        currencyLiveUseCase.unsubscribe()
    }
}