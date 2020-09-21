package br.com.leandrospidalieri.btgpactualconversion.viewmodel

import android.app.Application
import android.content.res.Resources
import android.graphics.Color
import androidx.core.content.ContextCompat
import androidx.core.content.res.ResourcesCompat
import androidx.lifecycle.*
import br.com.leandrospidalieri.btgpactualconversion.database.getDatabase
import br.com.leandrospidalieri.btgpactualconversion.domain.models.Currency
import br.com.leandrospidalieri.btgpactualconversion.repository.CurrencyRepository
import br.com.leandrospidalieri.btgpactualconversion.util.notifyObserver
import br.com.leandrospidalieri.btgpactualconversion.util.toFormattedCurrencyString
import kotlin.collections.ArrayList
import kotlin.coroutines.coroutineContext

class ConverterViewModel(application: Application) : AndroidViewModel(application){
    private val _selectedCurrencies = MutableLiveData<MutableList<Currency>>()
    val selectedCurrencies: LiveData<MutableList<Currency>>
        get() = _selectedCurrencies
    private val _exchangeRate = MutableLiveData<Double>()
    private val _valueToConvert = MutableLiveData<Double>()
    val convertedValue = Transformations.map(_valueToConvert){
        val firstCurrencyAmount : Double? = _valueToConvert.value
        val exchangeRateAmount: Double? = _exchangeRate.value
        if(exchangeRateAmount != null && firstCurrencyAmount != null)
            (exchangeRateAmount * firstCurrencyAmount).toFormattedCurrencyString()
        else 0.00

    }
    private val database = getDatabase(application)
    private val currenciesRepository = CurrencyRepository(database)
    val currencyList = currenciesRepository.currencies

    init {
        _selectedCurrencies.value = ArrayList()
    }

    fun addCurrencies(currency: Currency){
        _selectedCurrencies.value?.add(currency)
        if(_selectedCurrencies.value?.size == 2){
            _exchangeRate.value = calculateExchangeValue()
        }
        _selectedCurrencies.notifyObserver()
    }

    fun clearSelectedCurrencies(){
        _selectedCurrencies.value?.clear()
    }

    fun setValueToConvert(value: Double){
        _valueToConvert.value = value
    }

    private fun calculateExchangeValue(): Double{
        val firstElem: Currency? = _selectedCurrencies.value?.elementAt(0)
        val secondElem: Currency? = _selectedCurrencies.value?.elementAt(1)
        if(firstElem != null && secondElem != null)
            return secondElem.quote/firstElem.quote
        return 0.00
    }
}