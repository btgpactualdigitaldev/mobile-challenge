package com.vald3nir.btg_challenge.ui.home

import android.view.View
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.vald3nir.btg_challenge.core.base.BaseViewModel
import com.vald3nir.btg_challenge.items_view.CurrencyItemView
import com.vald3nir.btg_challenge.mapper.toCurrencyItemView
import com.vald3nir.data.repository.DataRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class HomeViewModel(private val dataRepository: DataRepository) : BaseViewModel() {

    private var inputValue = 0.0

    private val _calculateInputValueConversion = MutableLiveData<Double>()
    val calculateInputValueConversion: LiveData<Double> = _calculateInputValueConversion

    private val _inputCurrencyItemView = MutableLiveData<CurrencyItemView>()
    val inputCurrencyItemView: LiveData<CurrencyItemView> = _inputCurrencyItemView

    private val _outputCurrencyItemView = MutableLiveData<CurrencyItemView>()
    val outputCurrencyItemView: LiveData<CurrencyItemView> = _outputCurrencyItemView

    private val _loadCurrenciesFinished = MutableLiveData<Unit>()
    val loadCurrenciesFinished: LiveData<Unit> = _loadCurrenciesFinished

    private val _selectInputCurrency = MutableLiveData<Unit>()
    val selectInputCurrency: LiveData<Unit> = _selectInputCurrency

    private val _selectOutputCurrency = MutableLiveData<Unit>()
    val selectOutputCurrency: LiveData<Unit> = _selectOutputCurrency

    val selectInputCurrencyListener = View.OnClickListener {
        _selectInputCurrency.postValue(Unit)
    }
    val selectOutputCurrencyListener = View.OnClickListener {
        _selectOutputCurrency.postValue(Unit)
    }

    fun initCurrencies() {
        updateInputCurrency("BRL")
        updateOutputCurrency("USD")
    }

    fun updateInputValue(inputValue: String?) {
        try {
            this.inputValue = inputValue!!.toDouble()
        } catch (e: Exception) {
            this.inputValue = 0.0
            e.printStackTrace()
        }
    }

    fun changeCurrencies() {
        _inputCurrencyItemView.postValue(outputCurrencyItemView.value)
        _outputCurrencyItemView.postValue(inputCurrencyItemView.value)
        _loadCurrenciesFinished.postValue(Unit)
    }

    fun updateInputCurrency(code: String?) {
        launch {

            var inputCurrencyItemView: CurrencyItemView?
            withContext(Dispatchers.IO) {
                inputCurrencyItemView = dataRepository.getCurrency(code).toCurrencyItemView()
            }

            _inputCurrencyItemView.postValue(inputCurrencyItemView!!)
            _loadCurrenciesFinished.postValue(Unit)

            calculateConversion()
        }
    }

    fun updateOutputCurrency(code: String?) {
        launch {

            var outputCurrencyItemView: CurrencyItemView?
            withContext(Dispatchers.IO) {
                outputCurrencyItemView = dataRepository.getCurrency(code).toCurrencyItemView()
            }

            _outputCurrencyItemView.postValue(outputCurrencyItemView!!)
            _loadCurrenciesFinished.postValue(Unit)

            calculateConversion()
        }
    }

    fun calculateConversion() {
        val inputQuote = inputCurrencyItemView.value?.usdQuote
        val outputQuote = outputCurrencyItemView.value?.usdQuote
        if (inputQuote != null && outputQuote != null) {
            val valueCalculated = (this.inputValue / inputQuote) * outputQuote
            _calculateInputValueConversion.postValue(valueCalculated)
        }
    }
}