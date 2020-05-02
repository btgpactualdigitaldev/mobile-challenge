package io.felipeandrade.currencylayertest.ui.currency.conversion

import android.app.Activity
import android.content.Intent
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import io.felipeandrade.currencylayertest.ui.currency.selection.CurrencySelectionActivity
import io.felipeandrade.currencylayertest.usecase.ConvertUseCase
import io.felipeandrade.domain.CurrencyModel
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import java.math.BigDecimal
import java.math.RoundingMode

class CurrencyConversionViewModel(
    private val convert: ConvertUseCase
) : ViewModel() {


    val inputCurrency = MutableLiveData<CurrencyModel>()
    val inputValue = MutableLiveData<BigDecimal>()

    val outputCurrency = MutableLiveData<CurrencyModel>()
    val outputValue = MutableLiveData<ValueOutput>()


    val selectCurrencyCode = MutableLiveData<Int>()


    data class ValueOutput(
        val currency: CurrencyModel,
        val value: BigDecimal
    )


    fun inputBtnClicked() {
        selectCurrencyCode.value = (CurrencyConversionActivity.INPUT_REQ_CODE)
    }

    fun outputBtnClicked() {
        selectCurrencyCode.value = (CurrencyConversionActivity.OUTPUT_REQ_CODE)
    }

    fun inputValueUpdated(newValue: String) {
        inputValue.value = (newValue.toBigDecimal().setScale(2, RoundingMode.HALF_EVEN))
        calculateIfHaveAllInfo()
    }


    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {

        if (resultCode == Activity.RESULT_OK) {

            val name = data?.getStringExtra(CurrencySelectionActivity.SELECTED_CURRENCY_NAME)
            val symbol = data?.getStringExtra(CurrencySelectionActivity.SELECTED_CURRENCY_SYMBOL)

            if (name == null || symbol == null) return


            when (requestCode) {
                CurrencyConversionActivity.INPUT_REQ_CODE -> {
                    inputCurrency.value = (CurrencyModel(name, symbol))
                }
                CurrencyConversionActivity.OUTPUT_REQ_CODE -> {
                    outputCurrency.value = (CurrencyModel(name, symbol))
                }
            }
        }

        calculateIfHaveAllInfo()
    }

    private fun calculateIfHaveAllInfo() {

        val currencyIn = inputCurrency.value
        val valueIn = inputValue.value
        val currencyOut = outputCurrency.value

        if (currencyIn == null || valueIn == null || currencyOut == null) return

        GlobalScope.async {
            val valueOut = convert.invoke(currencyIn.symbol, currencyOut.symbol, valueIn)
            outputValue.postValue(ValueOutput(currencyOut, valueOut))
        }
    }
}