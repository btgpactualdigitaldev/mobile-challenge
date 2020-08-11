package com.svm.btgmoneyconverter.viewmodel

import android.provider.Settings.System.getString
import androidx.lifecycle.MutableLiveData
import com.svm.btgmoneyconverter.R
import com.svm.btgmoneyconverter.model.Currency
import com.svm.btgmoneyconverter.model.Quote
import com.svm.btgmoneyconverter.utils.CommonFunctions
import com.svm.btgmoneyconverter.utils.CommonFunctions.doubleToString
import com.svm.btgmoneyconverter.utils.CommonFunctions.stringReplaceComma
import com.svm.btgmoneyconverter.utils.INPUT_CURRENCY
import com.svm.btgmoneyconverter.utils.OUTPUT_CURRENCY

class ConverterVM: BaseVM() {

    var inputCurrency: MutableLiveData<Currency> = MutableLiveData()
    var outputCurrency: MutableLiveData<Currency> = MutableLiveData()
    var inputQuote: MutableLiveData<Quote> = MutableLiveData()
    var outputQuote: MutableLiveData<Quote> = MutableLiveData()
    var enableConverter: MutableLiveData<Boolean> = MutableLiveData()
    var convertedValue: MutableLiveData<String> = MutableLiveData()

    private var hasInputCurrency = false
    private var hasOutputCurrency = false

    fun onCurrencySelected(flow: Int?, symbol: String?){
        val currency = symbol?.let { cDb.findBySymbol(it) }

        when(flow){
            INPUT_CURRENCY -> {
                hasInputCurrency = true
                inputCurrency.postValue(currency)
                val quote = qDb.findBySymbol("USD$symbol")
                inputQuote.postValue(quote)
                enableButton()
            }
            OUTPUT_CURRENCY -> {
                outputCurrency.postValue(currency)
                val quote = qDb.findBySymbol("USD$symbol")
                outputQuote.postValue(quote)
                hasOutputCurrency = true
                enableButton()
            }
        }
    }

    private fun enableButton(){
        if(hasInputCurrency && hasOutputCurrency)
            enableConverter.postValue(true)
    }

    fun makeConvert(inputText: String){
        if(inputText.isEmpty()){
            CommonFunctions.showMessageShort(context, context.getString(R.string.error_empty_text))
        } else {

            val inputValue = (stringReplaceComma(inputText)).toDouble()

            if(inputValue < 0){
                CommonFunctions.showMessageShort(context, context.getString(R.string.error_empty_text))
            } else {
                val qInput = inputQuote.value?.value
                val qOutput = outputQuote.value?.value
                val finalValue = (inputValue / qInput!!) * qOutput!!
                convertedValue.postValue(doubleToString(finalValue))
            }

        }
    }

    fun chooseDefaultInitialValues(){
        if(qDb.getAll().isNotEmpty() && cDb.getAll().isNotEmpty()){
            inputCurrency.postValue(cDb.findBySymbol("BRL"))
            inputQuote.postValue(qDb.findBySymbol("USDBRL"))

            outputCurrency.postValue(cDb.findBySymbol("USD"))
            outputQuote.postValue(qDb.findBySymbol("USDUSD"))

            enableConverter.postValue(true)
        }
    }


}