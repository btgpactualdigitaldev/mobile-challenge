package com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.lucasnav.desafiobtg.core.livedata.SingleLiveEvent
import com.lucasnav.desafiobtg.modules.currencyConverter.interactor.CurrencyInteractor
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import com.lucasnav.desafiobtg.modules.currencyConverter.model.RequestError

class CurrencyViewmodel(
    private val currencyInteractor: CurrencyInteractor
) : ViewModel() {

    var currencies: MutableLiveData<List<Currency>> = MutableLiveData()
    var onLoadFinished = SingleLiveEvent<Void>()
    var onError = SingleLiveEvent<RequestError>()

    fun getCurrencies() {
        currencyInteractor.getCurrencies(
            onSuccess = { currencies ->
                this.currencies.value = currencies
                onLoadFinished.call()
            },
            onError = { errorMessage ->
                onError.value = errorMessage
                onLoadFinished.call()
            }
        )
    }

    fun searchCurrencies(
        query: String
    ) {
        currencyInteractor.searchCurrencies(
            query,
            onSuccess = {
                currencies.value = it
                onLoadFinished.call()
            },
            onError = {
                onError.value = it
                onLoadFinished.call()
            }
        )
    }
}
