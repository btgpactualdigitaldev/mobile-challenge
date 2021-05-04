package com.todeschini.currencyconverter.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.todeschini.currencyconverter.data.repository.ConverterRepository
import com.todeschini.currencyconverter.model.CurrencyName
import com.todeschini.currencyconverter.model.QuoteObject
import com.todeschini.currencyconverter.utils.convertMapToQuoteObject
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlin.math.roundToInt

class ConverterViewModel(
    private val repository: ConverterRepository
): ViewModel() {

    val exchangedValue = MutableLiveData<Double>()
    val loading = MutableLiveData<Boolean>()
    val error = MutableLiveData<Boolean>()

    fun getCurrentCurrency(firstCurrencyName: CurrencyName, secondCurrencyName: CurrencyName, amount: Double) {
        loading.value = true
        viewModelScope.launch (Dispatchers.IO) {
            val firstCurrencyResult = repository.getLiveCurrency(firstCurrencyName.initials)
            val secondCurrencyResult = repository.getLiveCurrency(secondCurrencyName.initials)

            if (firstCurrencyResult.isSuccessful && secondCurrencyResult.isSuccessful) {
                val firstQuote = convertMapToQuoteObject(firstCurrencyResult.body()?.quotes)
                val secondQuote = convertMapToQuoteObject(secondCurrencyResult.body()?.quotes)
                if (firstQuote != null && secondQuote != null) {
                    exchangedValue.value = quoteConverter(firstQuote.value, secondQuote.value, amount)
                }
                error.value = false
            } else {
                error.value = true
            }
            loading.value = false
        }
    }

    private fun quoteConverter(firstQuote: Double, secondQuote: Double, amount: Double): Double {
        var exchangedValue = firstQuote / secondQuote * amount
        exchangedValue *= 100

        var round = exchangedValue.roundToInt().toDouble()
        round /= 100

        return round
    }
}
