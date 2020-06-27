package com.btg.converter.presentation.view.converter

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.btg.converter.domain.entity.currency.Conversion
import com.btg.converter.domain.entity.quote.CurrentQuotes
import com.btg.converter.domain.interactor.GetCurrentQuotes
import com.btg.converter.domain.interactor.PerformConversion
import com.btg.converter.domain.util.form.ConversionForm
import com.btg.converter.domain.util.resource.Strings
import com.btg.converter.presentation.util.base.BaseViewModel
import com.btg.converter.presentation.util.dialog.DialogData

class ConverterViewModel constructor(
    private val getCurrentQuotes: GetCurrentQuotes,
    private val performConversion: PerformConversion,
    private val strings: Strings
) : BaseViewModel() {

    val conversion: LiveData<Conversion> get() = _conversion

    private val _conversion by lazy { MutableLiveData<Conversion>() }

    private var currentQuotes: CurrentQuotes? = null
    val conversionForm = ConversionForm()

    init {
        getCurrentQuotes()
    }

    fun performConversion() {
        if (currentQuotes == null) getCurrentQuotes()
        else {
            when {
                conversionForm.isCurrenciesEmpty() -> showEmptyCurrenciesDialog()
                conversionForm.isValueEmpty() -> showEmptyValueDialog()
                else -> {
                    currentQuotes?.let {
                        val convertedValue = performConversion.execute(conversionForm, it)
                        sendConversionResult(convertedValue)
                    }
                }
            }
        }
    }

    fun setConversionValue(conversionValue: String) {
        conversionForm.conversionValue = conversionValue.toDoubleOrNull()
    }

    private fun getCurrentQuotes() {
        launchDataLoad(onFailure = ::onFailure) {
            val currentQuotes = getCurrentQuotes.execute()
            if (currentQuotes?.success == false)
                showCurrentQuotesErrorDialog()
            else
                this.currentQuotes = currentQuotes
        }
    }

    private fun sendConversionResult(convertedValue: Double?) {
        if (convertedValue == null) {
            showConversionErrorDialog()
        } else {
            _conversion.value = Conversion(
                conversionForm.originCurrency,
                conversionForm.destinationCurrency,
                convertedValue
            )
        }
    }

    private fun showEmptyCurrenciesDialog() {
        setDialog(
            DialogData.confirm(
                strings.emptyFieldsErrorTitle,
                strings.emptyCurrenciesError,
                { /* Do Nothing */ },
                strings.globalOk,
                true
            )
        )
    }

    private fun showEmptyValueDialog() {
        setDialog(
            DialogData.confirm(
                strings.errorTitle,
                strings.emptyValueError,
                { /* Do Nothing */ },
                strings.globalOk,
                true
            )
        )
    }

    private fun showConversionErrorDialog() {
        setDialog(
            DialogData.confirm(
                strings.errorTitle,
                strings.conversionError,
                { /* Do Nothing */ },
                strings.globalOk,
                true
            )
        )
    }

    private fun showCurrentQuotesErrorDialog() {
        setDialog(
            DialogData.confirm(
                strings.errorTitle,
                strings.currentQuotesError,
                { /* Do Nothing */ },
                strings.globalOk,
                true
            )
        )
    }

    private fun onFailure(throwable: Throwable) {
        setDialog(throwable, ::getCurrentQuotes)
    }
}