package com.renderson.currency_converter.ui.main

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.renderson.currency_converter.models.Currency
import com.renderson.currency_converter.models.CurrencyResponse
import com.renderson.currency_converter.models.Quotes
import com.renderson.currency_converter.models.QuotesResponse
import com.renderson.currency_converter.other.Resource
import com.renderson.currency_converter.repository.CurrencyRepository
import kotlinx.coroutines.launch
import kotlin.math.roundToInt

class CurrencyViewModel @ViewModelInject constructor(
    private val repository: CurrencyRepository
) : ViewModel() {

    private val _currencies = MutableLiveData<Resource<CurrencyResponse>>()
    val currencies: LiveData<Resource<CurrencyResponse>> get() = _currencies

    private val _quotes = MutableLiveData<Resource<QuotesResponse>>()
    val quotes: LiveData<Resource<QuotesResponse>> get() = _quotes

    fun getAllCurrencies() = viewModelScope.launch {
        _currencies.postValue(Resource.loading(null))
        repository.getAllCurrencies().let { result ->
            if (result.isSuccessful)
                _currencies.postValue(Resource.success(result.body()))
            else
                _currencies.postValue(Resource.error(result.errorBody().toString(), null))
        }
    }

    fun getAllQuotes() = viewModelScope.launch {
        _quotes.postValue(Resource.loading(null))
        repository.getAllQuotes().let { result ->
            if (result.isSuccessful)
                _quotes.postValue(Resource.success(result.body()))
            else
                _quotes.postValue(Resource.error(result.errorBody().toString(), null))
        }
    }

    fun convertMapToArrayList(currency: CurrencyResponse?): ArrayList<Currency> {
        val map: Map<String, String> = currency!!.currencies
        val list = arrayListOf<Currency>()

        map.forEach { (key, value) ->
            list.add(Currency(key, value))
        }
        return list
    }

    fun convertMapToArrayListQuotes(quotes: QuotesResponse?): ArrayList<Quotes> {
        val map: Map<String, String> = quotes!!.quotes
        val list = arrayListOf<Quotes>()

        map.forEach { (key, value) ->
            list.add(Quotes(key, value))
        }
        return list
    }

    fun convertCurrency(origin: Double, destination: Double, amount: Double): Double {
        var changeValue = origin / destination * amount
        changeValue *= 100

        var round = changeValue.roundToInt().toDouble()
        round /= 100
        return round
    }
}