package com.mbarros64.btg_challenge.ui.fragment.home

import android.text.Editable
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.mbarros64.btg_challenge.database.entity.Currency
import com.mbarros64.btg_challenge.repository.HomeRepository
import kotlinx.coroutines.launch
import java.math.RoundingMode
import java.text.DecimalFormat

class HomeViewModel(private val homeRepository: HomeRepository) : ViewModel() {
    private val currencies : MutableLiveData<List<Currency>> = MutableLiveData()
    private val currencyInitials : MutableLiveData<List<String>> = MutableLiveData()

    val error : MutableLiveData<String> = MutableLiveData()
    val emptyList : MutableLiveData<Boolean> = MutableLiveData(true)

    val byCurrencyAdapter : MutableLiveData<Int> = MutableLiveData(0)
    val toCurrencyAdapter : MutableLiveData<Int> = MutableLiveData(0)

    val convertedCurrency : MutableLiveData<Double> = MutableLiveData(0.0)

    fun getCurrencies() : LiveData<List<Currency>> {
        try {
            viewModelScope.launch {
                val data = homeRepository.getExchangeRateValues().value
                currencies.value = data

                emptyList.value = currencies.value?.isEmpty() ?: true
            }
        }catch (e : Exception) {
            error.value = e.message
        }
        return currencies
    }

    fun getCurrenciesInitials() : LiveData<List<String>> {
        val initialsList = mutableListOf<String>()

        currencies.value?.forEach {
            initialsList.add(it.currency)
        }

        currencyInitials.postValue(initialsList)
        return currencyInitials
    }

    fun convertCurrencyAtoCurrencyB(text: Editable?): LiveData<Double> {
        if(emptyList.value!!){
            error.value = "Você não pode realizar essa operação"
        } else {
            val currencyAToUSDTaxes = currencies.value?.get(byCurrencyAdapter.value!!)?.rate ?: 1.0
            val currencyUSDToBTaxes = currencies.value?.get(toCurrencyAdapter.value!!)?.rate ?: 1.0

            if(text?.isNotEmpty()!!) {
                val input = text.toString().toDouble()
                val inputInUSD = input.div(currencyAToUSDTaxes)
                convertedCurrency.value = roundOffDecimal(number = (inputInUSD * currencyUSDToBTaxes))

            } else error.value = "Insira um valor"
        }
        return convertedCurrency
    }

    private fun roundOffDecimal(number: Double): Double {
        val decimalFormat = DecimalFormat("#.##")
        decimalFormat.roundingMode = RoundingMode.CEILING
        return decimalFormat.format(number).toDouble()
    }
}