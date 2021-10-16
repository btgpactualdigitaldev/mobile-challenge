package com.helano.converter.ui.converter

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.helano.converter.model.ExchangeRates
import com.helano.repository.CurrencyRepository
import com.helano.shared.Constants.DECIMAL_PLACES
import com.helano.shared.Constants.MILLIS_IN_SEC
import com.helano.shared.enums.Info
import com.helano.shared.model.Currency
import com.helano.shared.util.Preferences
import kotlinx.coroutines.launch
import java.text.SimpleDateFormat
import java.util.*

class ConverterViewModel @ViewModelInject constructor(
    private val repository: CurrencyRepository,
    private val prefs: Preferences
) : ViewModel() {

    val fromCurrency by lazy { MutableLiveData<Currency>() }
    val toCurrency by lazy { MutableLiveData<Currency>() }
    val currencyValue by lazy { MutableLiveData<String>() }
    val lastUpdate by lazy { MutableLiveData<String>() }
    val convertedCurrency by lazy { MutableLiveData<String>() }
    private val exchangeRates = ExchangeRates()

    val currencies by lazy { MutableLiveData<List<Currency>>() }

    fun start() {
        updateCurrencyInfo(prefs.fromCurrencyCode, Info.FROM)
        updateCurrencyInfo(prefs.toCurrencyCode, Info.TO)
        val valueToConvert = prefs.valueToConvert
        currencyValue.value = if (valueToConvert.isNotEmpty()) valueToConvert else "1"
        lastUpdate.value = getDate(prefs.lastUpdate)
    }

    fun updateCurrencyInfo(code: String, info: Info, updatePrefs: Boolean = false) {
        viewModelScope.launch {
            if (info == Info.FROM) {
                fromCurrency.value = repository.getCurrency(code)
                exchangeRates.from = repository.getCurrencyQuote("USD$code").value
                if (updatePrefs)
                    prefs.fromCurrencyCode = code
            } else {
                toCurrency.value = repository.getCurrency(code)
                exchangeRates.to = repository.getCurrencyQuote("USD$code").value
                if (updatePrefs)
                    prefs.toCurrencyCode = code
            }
        }
    }

    fun onValueChanged(value: String) {
        updateView(if (value.isNotEmpty() && value != ".") value.toFloat() else 0f)
        prefs.valueToConvert = value
    }

    fun onSwapClicked(value: String) {
        val newToCurrencyCode = prefs.fromCurrencyCode
        val newFromCurrencyCode = prefs.toCurrencyCode
        updateCurrencyInfo(newToCurrencyCode, Info.TO, true)
        updateCurrencyInfo(newFromCurrencyCode, Info.FROM, true)
        onValueChanged(value)
    }

    private fun updateView(value: Float) {
        convertedCurrency.value = DECIMAL_PLACES.format(value * (exchangeRates.to / exchangeRates.from))
    }

    private fun getDate(date: Long): String {
        return SimpleDateFormat(
            "HH:mm dd/MM/yyyy",
            Locale.getDefault()
        ).format(date * MILLIS_IN_SEC)
    }
}