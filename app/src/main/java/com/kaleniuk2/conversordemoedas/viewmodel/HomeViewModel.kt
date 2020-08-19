package com.kaleniuk2.conversordemoedas.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.kaleniuk2.conversordemoedas.data.DataWrapper
import com.kaleniuk2.conversordemoedas.data.model.Currency
import com.kaleniuk2.conversordemoedas.data.repository.CurrencyRepository
import com.kaleniuk2.conversordemoedas.data.repository.CurrencyRepositoryImpl
import com.kaleniuk2.conversordemoedas.util.NumberUtil
import java.math.BigDecimal

class HomeViewModel(private val repository: CurrencyRepository = CurrencyRepositoryImpl()) : ViewModel() {
    companion object {
        private const val ERROR_SELECT_ALL_CURRENCIES = "Selecione todas moedas"
        private const val ERROR_EMPTY_INPUT = "Preencha o campo valor"
        private const val ERROR_EQUAL_CURRENCIES = "As duas moedas devem ser diferentes"
    }

    val showLoading: MutableLiveData<Boolean> = MutableLiveData()
    val showError: MutableLiveData<String> = MutableLiveData()
    val convertSuccess: MutableLiveData<String> = MutableLiveData()

    fun interact(interact: Interact) {
        when (interact) {
            is Interact.Convert -> convert(interact)
        }
    }

    private fun convert(values: Interact.Convert) {
        showLoading.value = true
        if (values.currencyFrom.isEmpty() || values.currencyTo.isEmpty()) {
            showError(ERROR_SELECT_ALL_CURRENCIES)
            return
        }

        if (values.value.isEmpty()) {
            showError(ERROR_EMPTY_INPUT)
            return
        }

        if (values.currencyFrom == values.currencyTo) {
            showError(ERROR_EQUAL_CURRENCIES)
            return
        }

            repository.convert(values.currencyFrom, values.currencyTo) {
                when (it) {
                    is DataWrapper.Success -> {
                        convertSuccess.value = convertListToResult(it.value, values)

                    }
                    is DataWrapper.Error -> showError.value = it.error
                }

                showLoading.value = false
            }
    }

    private fun adjustAbbreviations(list: List<Currency>) {
        list[0].abbreviation =
            if (list[0].abbreviation != "USDUSD") {
                list[0].abbreviation.replace("USD", "")
            } else "USD"

        list[1].abbreviation =
            if (list[1].abbreviation != "USDUSD") {
                list[1].abbreviation.replace("USD", "")
            } else "USD"
    }

    private fun convertListToResult(list: List<Currency>, values: Interact.Convert): String {
        val value = NumberUtil.parseStringToBigDecimal(values.value)
        adjustAbbreviations(list)
        val from = if (list[0].abbreviation.contains(values.currencyFrom)) list[0] else list[1]
        val to = if (list[0].abbreviation.contains(values.currencyTo)) list[0] else list[1]

        return "${to.abbreviation} ${((to.value.divide(
            from.value, 2, BigDecimal.ROUND_CEILING
        )) * value)
            .setScale(2, BigDecimal.ROUND_CEILING)}"
    }

    private fun showError(error: String) {
        showLoading.value = false
        showError.value = error
    }

    sealed class Interact {
        class Convert(val currencyFrom: String,
                      val currencyTo: String, val value: String): Interact()
    }
}