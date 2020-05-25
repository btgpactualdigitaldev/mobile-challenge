package com.guioliveiraapps.btg

import android.content.Context
import android.view.View
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.guioliveiraapps.btg.room.Currency
import com.guioliveiraapps.btg.room.Quote
import com.guioliveiraapps.btg.service.ApiService

class MainActivityViewModel : ViewModel() {

    val currencies = MutableLiveData<List<Currency>>()
    val quotes = MutableLiveData<List<Quote>>()
    val finalValue: MutableLiveData<Double> = MutableLiveData(0.0)
    val showFragments: MutableLiveData<Boolean> = MutableLiveData(false)

    val loading: MutableLiveData<Boolean> = MutableLiveData(true)
    val internetError: MutableLiveData<Boolean> = MutableLiveData(false)
    val serverError: MutableLiveData<Boolean> = MutableLiveData(false)

    val updateError: MutableLiveData<Int> = MutableLiveData(View.GONE)

    fun getCurrencies(context: Context) {
        ApiService.getCurrencies(context, currencies, internetError, serverError, updateError)
        loading.value = true
        internetError.value = false
        serverError.value = false
        updateError.value = View.GONE
    }

    fun getQuotes(context: Context) {
        ApiService.getQuotes(context, quotes, internetError, serverError, updateError)
        loading.value = true
        internetError.value = false
        serverError.value = false
        updateError.value = View.GONE
    }

    fun updateFinalValue(
        firstCurrency: Currency,
        secondCurrency: Currency,
        value: Double
    ) {
        if (isTheSame(firstCurrency, secondCurrency)) {
            finalValue.value = value
            return
        }

        val quoteKey: String = firstCurrency.initials + secondCurrency.initials

        var res: Quote? = quotes.value?.find {
            it.initials == quoteKey
        }

        if (res != null) {
            finalValue.value = value * res.value
            return
        }

        val invertedQuoteKey: String = secondCurrency.initials + firstCurrency.initials

        res = quotes.value?.find {
            it.initials == invertedQuoteKey
        }

        if (res != null) {
            finalValue.value = value / res.value
            return
        }

        val f1: Quote? = quotes.value?.find {
            it.initials == "USD" + firstCurrency.initials
        }

        if (f1 == null) {
            finalValue.value = 0.0
            return
        }

        val f2: Quote? = quotes.value?.find {
            it.initials == "USD" + secondCurrency.initials
        }

        if (f2 == null) {
            finalValue.value = 0.0
            return
        }

        finalValue.value = (value / f1.value) * f2.value
    }

    private fun isTheSame(
        firstCurrency: Currency,
        secondCurrency: Currency
    ): Boolean {
        return firstCurrency.initials == secondCurrency.initials
    }

}