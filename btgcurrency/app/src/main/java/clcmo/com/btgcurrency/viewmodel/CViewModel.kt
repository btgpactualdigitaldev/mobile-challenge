package clcmo.com.btgcurrency.viewmodel

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import clcmo.com.btgcurrency.repository.domain.model.Currency
import clcmo.com.btgcurrency.repository.domain.uc.CUserCase
import clcmo.com.btgcurrency.util.Result.*
import clcmo.com.btgcurrency.util.constants.Constants.DEF_EMPTY_VALUE
import clcmo.com.btgcurrency.util.constants.Constants.DEF_MASK
import clcmo.com.btgcurrency.util.constants.Constants.DEF_MIN_VALUE
import clcmo.com.btgcurrency.util.constants.Constants.State.*
import clcmo.com.btgcurrency.view.model.CurrencyUI

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.withContext
import java.lang.String.format
import java.util.*

class CViewModel(application: Application, private val userCase: CUserCase) :
    AndroidViewModel(application) {

    private var currencies = listOf<Currency>()
    var fromCurrency: CurrencyUI? = null
        get() = field?.let { getCurrencyUI(it) }
    var toCurrency: CurrencyUI? = null
        get() = field?.let { getCurrencyUI(it) }


    fun requestListOfCurrencies() = flow {
        when {
            currencies.isNotEmpty() -> return@flow emit(LOADED)
            else -> {
                emit(LOADING)

                when (val response = withContext(Dispatchers.IO) { userCase.currencies() }) {
                    is Success -> {
                        currencies = response.dataResult
                        emit(
                            when {
                                currencies.isEmpty() -> CONTENT_EX
                                else -> LOADED
                            }
                        )
                    }
                    is Failure -> emit(ERROR)
                }
            }
        }
    }

    fun getListOfCurrencies() = currencies.map { CurrencyUI.fromEntity(it) }

    private fun getCurrencyUI(currencyUI: CurrencyUI) =  when (currencyUI) {
        null -> getListOfCurrencies().firstOrNull()
        else -> currencyUI
    }

    suspend fun calcConvert(value: CharSequence?) = flow {
        val toConvert = value?.toString() ?: return@flow emit(resultConvert(DEF_MIN_VALUE))
        when {
            !isValidConvert(toConvert) -> return@flow emit(resultConvert(DEF_MIN_VALUE))
            else -> {
                val currencyFrom = getCurrencyById(fromCurrency?.id) ?: return@flow emit(
                    resultConvert(DEF_MIN_VALUE)
                )
                val currencyTo = getCurrencyById(toCurrency?.id)
                    ?: return@flow emit(resultConvert(DEF_MIN_VALUE))

                when (val response =
                    userCase.convertValue(toConvert.toFloat(), currencyFrom, currencyTo)) {
                    is Success -> emit(resultConvert(response.dataResult))
                    is Failure -> emit(resultConvert(DEF_MIN_VALUE))
                }
            }
        }
    }

    private fun isValidConvert(value: String) = try {
        value.toFloat()
        true
    } catch (e: Exception) {
        false
    }

    private fun getCurrencyById(id: String?) = currencies.find { it.id == id }

    private fun resultConvert(value: Float = DEF_MIN_VALUE): String {
        val toCurrency = getCurrencyById(toCurrency?.id) ?: return DEF_EMPTY_VALUE
        return format(Locale.getDefault(), DEF_MASK, toCurrency.id, value)
    }
}