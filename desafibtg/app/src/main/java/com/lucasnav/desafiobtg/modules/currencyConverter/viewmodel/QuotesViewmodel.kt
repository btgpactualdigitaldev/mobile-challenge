package com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.lucasnav.desafiobtg.core.livedata.SingleLiveEvent
import com.lucasnav.desafiobtg.modules.currencyConverter.interactor.CurrencyInteractor
import com.lucasnav.desafiobtg.modules.currencyConverter.model.RequestError

const val I_HAVE_FOCUSED = 0
const val I_WANT_FOCUSED = 1

class QuotesViewmodel(
    private val currencyInteractor: CurrencyInteractor
) : ViewModel() {

    var amount: MutableLiveData<String> = MutableLiveData()

    var currentFocused = I_HAVE_FOCUSED

    var onLoadFinished = SingleLiveEvent<Void>()
    var onloadStarted = SingleLiveEvent<Void>()
    var onError = SingleLiveEvent<RequestError>()

    init {
        currencyInteractor.getAllQuotesFromApiAndSave()
    }

    fun getQuotesAndCalculateAmount(
        amount: String,
        firstCurrency: String,
        secondCurrency: String
    ) {

        onloadStarted.call()

        currencyInteractor.getQuotesAndCalculateAmount(
            amount,
            firstCurrency,
            secondCurrency,
            onSuccess = {
                this.amount.value = it.toString()
                onLoadFinished.call()
            },
            onError = {
                onLoadFinished.call()
                onError.value = it
            }
        )
    }
}
