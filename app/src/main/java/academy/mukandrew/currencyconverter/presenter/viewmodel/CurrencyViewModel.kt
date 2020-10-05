package academy.mukandrew.currencyconverter.presenter.viewmodel

import academy.mukandrew.currencyconverter.commons.Result.Failure
import academy.mukandrew.currencyconverter.commons.Result.Success
import academy.mukandrew.currencyconverter.commons.models.UIState
import academy.mukandrew.currencyconverter.domain.models.Currency
import academy.mukandrew.currencyconverter.domain.usecases.CurrencyUseCase
import academy.mukandrew.currencyconverter.presenter.models.CurrencyUI
import android.app.Application
import androidx.lifecycle.AndroidViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.withContext
import java.util.*

class CurrencyViewModel(
    application: Application,
    private val useCase: CurrencyUseCase
) : AndroidViewModel(application) {

    companion object {
        const val MIN_CONVERTED_VALUE = 0f
        const val FORMAT_MASK = "%1s %.3f"
        const val EMPTY_STR_VALUE = "0,00"
    }

    private var currencyList = listOf<Currency>()
    var fromCurrency: CurrencyUI? = null
        get() = getCurrencyUI(field)
    var toCurrency: CurrencyUI? = null
        get() = getCurrencyUI(field)

    fun requestCurrencyList() = flow {
        if (currencyList.isNotEmpty()) return@flow emit(UIState.LOADED)

        emit(UIState.LOADING)

        when (val response = withContext(Dispatchers.IO) { useCase.list() }) {
            is Success -> {
                currencyList = response.data
                emit(if (currencyList.isEmpty()) UIState.NO_CONTENT else UIState.LOADED)
            }
            is Failure -> emit(UIState.ERROR)
        }
    }

    fun getCurrencyList(): List<CurrencyUI> {
        return currencyList.map { CurrencyUI.fromEntity(it) }
    }

    private fun getCurrencyUI(currencyUI: CurrencyUI?): CurrencyUI? {
        return when (currencyUI) {
            null -> getCurrencyList().firstOrNull()
            else -> currencyUI
        }
    }

    suspend fun calculateConversion(value: CharSequence?) = flow {
        val toConvert = value?.toString() ?: return@flow emit(formatConversionResult(MIN_CONVERTED_VALUE))
        if (!isValidValueToConvert(toConvert)) return@flow emit(formatConversionResult(MIN_CONVERTED_VALUE))

        val currencyFrom = getCurrencyByCode(fromCurrency?.code) ?: return@flow emit(formatConversionResult(MIN_CONVERTED_VALUE))
        val currencyTo = getCurrencyByCode(toCurrency?.code) ?: return@flow emit(formatConversionResult(MIN_CONVERTED_VALUE))

        val response = useCase.convert(
            toConvert.toFloat(),
            currencyFrom,
            currencyTo
        )

        when (response) {
            is Success -> emit(formatConversionResult(response.data))
            is Failure -> emit(formatConversionResult(MIN_CONVERTED_VALUE))
        }
    }

    private fun formatConversionResult(result: Float = 0f): String {
        val toCurrency = getCurrencyByCode(toCurrency?.code) ?: return EMPTY_STR_VALUE
        return String.format(Locale.getDefault(), FORMAT_MASK, toCurrency.code, result)
    }

    private fun getCurrencyByCode(code: String?): Currency? {
        return currencyList.find { it.code == code }
    }

    private fun isValidValueToConvert(toConvert: String): Boolean {
        return try {
            toConvert.toFloat()
            true
        } catch (e: Exception) {
            false
        }
    }

}