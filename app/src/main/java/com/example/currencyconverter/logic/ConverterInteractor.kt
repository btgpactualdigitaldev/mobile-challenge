package com.example.currencyconverter.logic

import android.content.Context
import android.content.Intent
import com.example.currencyconverter.entity.Currency
import com.example.currencyconverter.infrastructure.database.Database
import com.example.currencyconverter.infrastructure.network.CurrencyAPIService
import com.example.currencyconverter.infrastructure.network.ListAPIResponseModel
import com.example.currencyconverter.infrastructure.network.LiveAPIResponseModel
import com.example.currencyconverter.infrastructure.network.isOnline
import com.example.currencyconverter.presentation.converter.ConverterView
import com.example.currencyconverter.presentation.converter.MessageView
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.schedulers.Schedulers

class ConverterInteractor (val converterView : ConverterView,
                           val messageView : MessageView,
                           val database: Database,
                           val compositeDisposable: CompositeDisposable) {

    val ORIGINAL_REQUEST_CODE = 101
    val CONVERTED_REQUEST_CODE = 102

    var listResponse : ListAPIResponseModel? = null
    var liveResponse : LiveAPIResponseModel? = null
    var currencyList : List<Currency>? = null

    var originalCurrency : Currency? = null
    var convertedCurrency : Currency? = null
    var originalValue : Double? = null

    fun onCreate(context: Context) {
        database.onCreate()
        if(isOnline(context)) {
            refreshCurrencies()
        } else {
          throwError("Not connected to internet, we could not refresh the quotes.")
        }
    }

    fun saveCurrencyListToDatabase(currencyList: List<Currency>) {
        database.postCurrencies(currencyList)
        messageView.showToast("Currency list updated!")
    }

    fun refreshCurrencies() {
        //first call get the currencies symbols and names
        compositeDisposable.add(
            CurrencyAPIService.create().getCurrencyList()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                listResponse = it
                //second call to get the quotes for all the currencies
                compositeDisposable.clear()
                compositeDisposable.add(
                    CurrencyAPIService.create().getLiveQuotes()
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe({ response ->
                        liveResponse = response
                        compileResponsesIntoCurrencyList()
                    }, {
                        throwError("Network error")
                    })
                )
            }, {
                throwError("Network error")
            })
        )
    }

    fun compileResponsesIntoCurrencyList() {
        val currencies = listResponse?.currencies?.toList()
        val quotes = liveResponse?.quotes?.toList()
        currencyList = currencies?.map{
            var price = 0.0
            quotes?.find { value ->
                value.first == ("USD"+it.first)
            }?.apply { price = this.second }

            Currency(
                symbol =  it.first,
                name = it.second,
                quote = price
            )
        }
        currencyList?.let { saveCurrencyListToDatabase(it) }
    }

    fun treatActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        when(requestCode) {
            ORIGINAL_REQUEST_CODE -> {
                originalCurrency = data?.getParcelableExtra("selectedCurrency") as Currency
                originalCurrency?.let { converterView.setOriginalCurrencyButtonText(it.symbol) }
            }
            CONVERTED_REQUEST_CODE -> {
                convertedCurrency = data?.getParcelableExtra("selectedCurrency") as Currency
                convertedCurrency?.let { converterView.setConvertedCurrencyButtonText(it.symbol) }
            }
        }
    }

     fun originalValueChanged(enteredValue: String) {
         if (enteredValue.isBlank()) return
         originalValue = enteredValue.toDouble()
     }

    fun openListForCurrencySelection(requestCode: Int) {
        converterView.showCurrencyList(requestCode)
    }

    fun selectOriginalCurrency() {
        openListForCurrencySelection(ORIGINAL_REQUEST_CODE)
        converterView?.setConvertedValueText("") //clean the text when changing the currency
    }

    fun selectTargetCurrency() {
        openListForCurrencySelection(CONVERTED_REQUEST_CODE)
        converterView?.setConvertedValueText("") //clean the text when changing currency
    }

    private fun allValuesFullfilled() : Boolean {
        if (originalValue == null) {
            throwError("Fill the original Value field")
            return false
        }
        if (originalCurrency == null) {
            throwError("Select the original currency")
            return false
        }
        if (convertedCurrency == null) {
            throwError("Select the target currency of the conversion")
            return false
        }
        return true
    }

    fun convert() {
        if(allValuesFullfilled()) {
            val finalValue = calculateConvertedValue()
            converterView.setConvertedValueText(String.format("%.2f", finalValue))
        }
    }

    fun calculateConvertedValue() : Double = originalValue!! * convertedCurrency!!.quote / originalCurrency!!.quote

    fun throwError(message : String) {
        messageView.showToast(message)
    }

    fun onDestroy() {
        database.onDestroy()
    }
}