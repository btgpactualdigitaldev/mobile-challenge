package fps.daniel.conversormoedas.domain

import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.annotation.RequiresApi
import fps.daniel.conversormoedas.data.Data
import fps.daniel.conversormoedas.enity.CurrencyLayer
import fps.daniel.conversormoedas.response.CurrencyAPI
import fps.daniel.conversormoedas.response.ListAPI
import fps.daniel.conversormoedas.response.LiveAPI
import fps.daniel.conversormoedas.response.isOnline
import fps.daniel.conversormoedas.viewmodel.ConversionView
import fps.daniel.conversormoedas.viewmodel.MessageView
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.schedulers.Schedulers

class ConversionLayer (val converterView : ConversionView,
                       val messageView : MessageView,
                       val database: Data,
                       val compositeDisposable: CompositeDisposable
) {

    val ORIGINAL_REQUEST_CODE = 101
    val CONVERTED_REQUEST_CODE = 102

    var listResponse : ListAPI? = null
    var liveResponse : LiveAPI? = null
    var currencyList : List<CurrencyLayer>? = null

    var originalCurrency : CurrencyLayer? = null
    var convertedCurrency : CurrencyLayer? = null
    var originalValue : Double? = null

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun onCreate(context: Context) {
        database.onCreate()
        if(isOnline(context)) {
            refreshCurrencies()
        } else {
            throwError("Not connected to internet, we could not refresh the quotes.")
        }
    }

    fun saveCurrencyListToDatabase(currencyList: List<CurrencyLayer>) {
        database.postCurrencies(currencyList)
        messageView.showToast("Currency list updated!")
    }

    fun refreshCurrencies() {
        //first call get the currencies symbols and names
        compositeDisposable.add(
            CurrencyAPI.create().getCurrencyList()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe({
                    listResponse = it
                    //second call to get the quotes for all the currencies
                    compositeDisposable.clear()
                    compositeDisposable.add(
                        CurrencyAPI.create().getLiveQuotes()
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

            CurrencyLayer(
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
                originalCurrency = data?.getParcelableExtra("selectedCurrency") as CurrencyLayer
                originalCurrency?.let { converterView.setOriginalCurrencyButtonText(it.symbol) }
            }
            CONVERTED_REQUEST_CODE -> {
                convertedCurrency = data?.getParcelableExtra("selectedCurrency") as CurrencyLayer
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