package br.com.gft.main

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import br.com.gft.main.interactor.CurrencyConverterParams
import br.com.gft.main.interactor.CurrencyConverterUseCase
import br.com.gft.main.iteractor.model.Currency
import kotlinx.coroutines.launch

class MainViewModel(private val currencyConverterUseCase: CurrencyConverterUseCase) : ViewModel() {
    val valueConvertedLiveData: MutableLiveData<Float> = MutableLiveData()
    val errorLiveData: MutableLiveData<String> = MutableLiveData()
    val loadingLiveData: MutableLiveData<Boolean> = MutableLiveData()

    val pickedCurrencyFromLiveData: MutableLiveData<Currency> = MutableLiveData()
    val pickedCurrencyToLiveData: MutableLiveData<Currency> = MutableLiveData()
    val amountToConvertLiveData: MutableLiveData<Float> = MutableLiveData()

    init {
        amountToConvertLiveData.postValue(0F)
    }

    fun convertAmountToAnotherCurrency() {
        clearErrorMessage()

        loadingLiveData.postValue(true)
        viewModelScope.launch {
            val currencyFrom = pickedCurrencyFromLiveData.value!!.code
            val currencyTo = pickedCurrencyToLiveData.value!!.code
            val amountToConvert = amountToConvertLiveData.value!!

            val response = currencyConverterUseCase(
                CurrencyConverterParams(
                    currencyFrom,
                    currencyTo,
                    amountToConvert
                )
            )

            loadingLiveData.postValue(false)

            when (response.status) {
                Resource.Status.SUCCESS -> {
                    response.data?.let {
                        clearErrorMessage()
                        valueConvertedLiveData.postValue(it)
                    }
                }
                Resource.Status.ERROR -> {
                    response.exception?.let {
                        errorLiveData.postValue(it.message)
                    }
                }
            }
        }
    }

    private fun clearErrorMessage() {
        errorLiveData.postValue("")
    }

    fun canIEnableButtonCurrencyTo(): Boolean {
        return !pickedCurrencyFromLiveData.value?.code.isNullOrEmpty()
    }

    fun canIEnableFieldAmountToConvert(): Boolean {
        return canIEnableButtonCurrencyTo() && !pickedCurrencyToLiveData.value?.code.isNullOrEmpty()
    }

    fun canIEnableButtonConvert(): Boolean {
        return canIEnableFieldAmountToConvert() && amountToConvertLiveData.value != 0F
    }
}