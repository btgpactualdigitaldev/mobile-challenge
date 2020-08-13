package com.example.cassiomobilechallenge.viewmodels

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import com.example.cassiomobilechallenge.models.Currency
import com.example.cassiomobilechallenge.models.CurrencyResponse
import com.example.cassiomobilechallenge.models.QuotesResponse
import com.example.cassiomobilechallenge.repositories.CurrencyRepository

class MainViewModel(val repository: CurrencyRepository,
                    application: Application
) : AndroidViewModel(application) {

    val errorMessage = MutableLiveData<String>().apply { value = null }
    val currencies = MutableLiveData<CurrencyResponse>().apply { value = null }
    val countryCurrencies = MutableLiveData<ArrayList<Currency>>().apply { value = ArrayList() }
    val currencyFrom = MutableLiveData<Currency>().apply { value = null }
    val currencyTo = MutableLiveData<Currency>().apply { value = null }
    val allConversions = MutableLiveData<QuotesResponse>().apply { value = null }
    val conversion = MutableLiveData<QuotesResponse>().apply { value = null }
    val valueEntry = MutableLiveData<Double>().apply { value = null }

    fun getCurrencies() {
        repository.getCurrencies(currencies, errorMessage)
    }

    fun getCountryCurrencies(data: HashMap<String, String>) {
        var values = ArrayList<Currency>()
        data.forEach { (code: String, name: String) -> values.add(Currency(code, name)) }
        values.sortBy { currency -> currency.currencyCode }
        countryCurrencies.postValue(values)
    }

    fun getAllConversions() {
        repository.getAllConversions(allConversions, errorMessage)
    }

    fun getConversion(toCurrency: String) {
        repository.getConversion(conversion, errorMessage, toCurrency)
    }

    fun calculateConversion() : Double {
        var convertedValue = 0.0

        var fromUSDtoCurrency: Double = 1.0
        allConversions.value!!.quotes.forEach { (usdCode: String, value: Double) ->
            var code: String = usdCode.removePrefix("USD")
            if (code.equals(currencyTo.value!!.currencyCode)) fromUSDtoCurrency = value
        }

        var key: String = "USD" + currencyFrom.value!!.currencyCode
        var dem = conversion.value!!.quotes.getOrDefault(key, 1.0)

        convertedValue = fromUSDtoCurrency / dem

        return convertedValue
    }

}