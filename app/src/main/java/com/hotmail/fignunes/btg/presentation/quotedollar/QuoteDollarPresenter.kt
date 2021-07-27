package com.hotmail.fignunes.btg.presentation.quotedollar

import android.content.Intent
import com.hotmail.fignunes.btg.BuildConfig
import com.hotmail.fignunes.btg.R
import com.hotmail.fignunes.btg.R.string
import com.hotmail.fignunes.btg.common.BasePresenter
import com.hotmail.fignunes.btg.common.StringHelper
import com.hotmail.fignunes.btg.common.exceptions.EmptyReturnException
import com.hotmail.fignunes.btg.common.exceptions.ReturnApiException
import com.hotmail.fignunes.btg.model.ChooseCurrency
import com.hotmail.fignunes.btg.model.Currency
import com.hotmail.fignunes.btg.presentation.common.CheckIsOnline
import com.hotmail.fignunes.btg.presentation.common.ReadInstanceProperty
import com.hotmail.fignunes.btg.presentation.quotedollar.actions.GetCurrencies
import com.hotmail.fignunes.btg.presentation.quotedollar.actions.GetQuoteDollar
import com.hotmail.fignunes.btg.presentation.quotedollar.actions.ResponsesToCurrency
import com.hotmail.fignunes.btg.presentation.quotedollar.actions.SaveCurrencies
import com.hotmail.fignunes.btg.repository.remote.error.GenericErrorCode
import com.hotmail.fignunes.btg.repository.remote.quotedollar.responses.QuoteDollarResponses
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.HttpException
import java.text.DecimalFormat

class QuoteDollarPresenter(
    private val contract: QuoteDollarContract,
    private val getQuoteDollar: GetQuoteDollar,
    private val checkIsOnline: CheckIsOnline,
    private val getCurrencies: GetCurrencies,
    private val responsesToCurrency: ResponsesToCurrency,
    private val saveCurrencies: SaveCurrencies,
    private val stringHelper: StringHelper,
    private val readInstanceProperty: ReadInstanceProperty
) : BasePresenter() {

    val accessKey = BuildConfig.ACCESS_KEY
    val dollarAcronym = stringHelper.getString(string.dollar_acronym)
    var currencySource: Currency? = null
    var currencyDestiny: Currency? = null
    var currencies: String = ""

    var source: String = ""
        set(value) {
            field = value
            notifyChange()
        }

    var destiny: String = ""
        set(value) {
            field = value
            notifyChange()
        }

    var conversionValue: String = ""
        set(value) {
            field = value
            notifyChange()
        }

    var result: String = ""
    set(value) {
        field = value
        notifyChange()
    }

    fun onCreate() {
        clear()
        searchCurrencyList()
    }

    fun clear() {
        currencySource = null
        currencyDestiny = null
        source = stringHelper.getString(R.string.choose_the_currency_of_origin)
        destiny = stringHelper.getString(R.string.choose_the_target_currency)
        conversionValue = ""
        result = ""
    }

    fun searchCurrencyList() {
        if (!checkIsOnline.execute()) {
            contract.message(stringHelper.getString(string.without_internet_connection))
        }

        getCurrencies.execute(accessKey)
            .map {
                if(it.success) {
                    responsesToCurrency.execute(it.currencies)
                } else {
                    throw ReturnApiException("${it.error.code} -> ${it.error.info}")
                }
            }
            .flatMap { saveCurrencies.execute(it) }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({},
                {
                    when (it) {
                        is ReturnApiException -> it.message
                        is EmptyReturnException -> stringHelper.getString(string.empty_return)
                        is HttpException -> httpExceptionHanding(it.code())
                        else -> stringHelper.getString(string.service_unhandled_error)
                    }.apply { contract.message(this!!) }

                })
            .also { addDisposable(it) }
    }

    fun sourceClick() {
        contract.source()
    }

    fun destinyClick() {
        contract.destiny()
    }

    fun currencyConverterClick() {
        if (currencySource == null) {
            contract.message(stringHelper.getString(string.fill_in_the_original_currency))
            return
        }

        if (currencyDestiny == null) {
            contract.message(stringHelper.getString(string.fill_in_the_target_currency))
            return
        }

        if(currencySource == currencyDestiny) {
            contract.message(stringHelper.getString(string.choose_diferent_currencies))
            return
        }

        if (conversionValue.isNullOrBlank()) {
            contract.message(stringHelper.getString(string.fill_in_the_amount))
            return
        }

        currencySource?.let { currencies = it.id + "," }
        currencyDestiny?.let { currencies += it.id }

        contract.hideKeyboard()
        contract.progressbar(true)
        result = ""

        getQuoteDollar.execute(accessKey, currencies)
            .map {
                if(it.success) {
                    conversion(it)
                } else {
                    throw ReturnApiException("${it.error.code} -> ${it.error.info}")
                }
            }
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                contract.progressbar(false)
            }, {
                contract.progressbar(false)
                when (it) {
                    is ReturnApiException -> it.message
                    is EmptyReturnException -> stringHelper.getString(string.empty_return)
                    is HttpException -> httpExceptionHanding(it.code())
                    else -> stringHelper.getString(string.service_unhandled_error)
                }.apply { contract.message(this!!) }

            })
            .also { addDisposable(it) }
    }

    private fun conversion(response: QuoteDollarResponses) {
        val sourceQuote = readInstanceProperty.execute<Double>(response.quotes, dollarAcronym + currencySource!!.id)
        val destinyQuote = readInstanceProperty.execute<Double>(response.quotes, dollarAcronym + currencyDestiny!!.id)

        val calculation = conversionValue.toDouble() / sourceQuote * destinyQuote
        val  decimal = DecimalFormat("0.00")
        result = decimal.format(calculation)
    }

    fun chooseCurrency(data: Intent?) {
        val chooseCurrency = data!!.getStringExtra(QuoteDollarActivity.CHOOSE_CURRENCY)
        val currency = data!!.getParcelableExtra<Currency>(QuoteDollarActivity.CURRENCY)

        when (chooseCurrency!!) {
            ChooseCurrency.SOURCE.toString() -> {
                currencySource = currency
                source = currencySource!!.description
            }
            ChooseCurrency.DESTINY.toString() -> {
                currencyDestiny = currency
                destiny = currencyDestiny!!.description
            }
        }
    }

    private fun httpExceptionHanding(code: Int) =
        when (code) {
            GenericErrorCode.UNAVAILABLE_SERVICE.code -> stringHelper.getString(string.unavailable_service)
            GenericErrorCode.ERROR_UNEXPECTED.code -> stringHelper.getString(string.error_unexpected)
            else -> stringHelper.getString(string.service_unhandled_error)
        }
}