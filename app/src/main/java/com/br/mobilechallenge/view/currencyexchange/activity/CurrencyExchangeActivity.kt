package com.br.mobilechallenge.view.currencyexchange.activity

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.util.LogPrinter
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import com.br.mobilechallenge.R
import com.br.mobilechallenge.helper.ListMap
import com.br.mobilechallenge.model.MappingObject
import com.br.mobilechallenge.view.currencies.activity.CurrenciesActivity
import com.br.mobilechallenge.viewmodel.ViewModelCurrencyNames
import com.br.mobilechallenge.viewmodel.ViewModelQuotes
import java.util.ArrayList
import kotlin.math.roundToInt


class CurrencyExchangeActivity() : AppCompatActivity(), ListMap {

    /*
    *           VIEWMODEL - LIST
    */
    private var currencyNameList = ArrayList<MappingObject>()
    private val viewModelCurrencyNames by lazy {
        ViewModelProviders.of(this).get(ViewModelCurrencyNames::class.java)
    }

    /*
    *           VIEWMODEL - LIVE
    */

    private var currencyQuotesList = ArrayList<MappingObject>()
    private val viewModelCurrencyQuotes by lazy {
        ViewModelProviders.of(this).get(ViewModelQuotes::class.java)
    }

    /*
    *           SPINNERS
    */

    private val spinnerFrom by lazy { findViewById<Spinner>(R.id.from_spinner) }
    private val spinnerTo by lazy { findViewById<Spinner>(R.id.to_spinner) }

    var fromValue: Int? = 0
    var toValue: Int? = 0

    /*
    *           EXCHANGE TEXT AND CURRENT CURRENCY
    */

    private val exchange by lazy { findViewById<TextView>(R.id.exchange_value) }
    private val currentCurrency by lazy { findViewById<TextView>(R.id.exchange_current_currency) }

    /*
    *           AMOUNT EXCHANGE EditText
    */

    private val amount by lazy { findViewById<EditText>(R.id.amount_value) }

    /*
    *           CALCULATE BUTTON
    */

    private val calculateButton by lazy { findViewById<Button>(R.id.calculate_button) }

    /*
    *           ALL CURRENCIES ACTIVITY BUTTON
    */

    private val allCurrenciesButton by lazy { findViewById<Button>(R.id.all_currencies_button) }


    companion object{

        var CO_NAME_KEYS = mutableListOf<String>()
        var CO_NAME_VALUES = mutableListOf<String>()
        var CO_QUOTE_KEYS = mutableListOf<String>()
        var CO_QUOTE_VALUES = mutableListOf<String>()

    }

    /*
    *           INÍCIO onCreate()
    */

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)

        initView()
        setViewModelList()
        setViewModelLive()
        calculate()
        allCurrencies()



    }

    private fun initView() {
        setContentView(R.layout.activity_currency_exchange)

    }

    private fun setViewModelList() {

        viewModelCurrencyNames.getCurrencyNames()
        viewModelCurrencyNames.currencyNames.observe(this, Observer {
            it?.let { itChar ->
                currencyNameList.addAll(itChar)
                setSpinnerFrom()
                setSpinnerTo()

            }
        })
    }

    private fun setViewModelLive() {

        viewModelCurrencyQuotes.getCurrencyQuotes()
        viewModelCurrencyQuotes.currencyQuotes.observe(this, Observer {
            it?.let { itChar ->
                currencyQuotesList.addAll(itChar)
            }
        })
    }

    private fun setSpinnerFrom() {

        val currencyArrayNames = getValues(currencyNameList).toTypedArray()
        val spinnerFromAdapter =
            ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, currencyArrayNames)
        spinnerFrom.adapter = spinnerFromAdapter

    }

    private fun setSpinnerTo() {

        val currencyArrayNames = getValues(currencyNameList).toTypedArray()
        val spinnerToAdapter =
            ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, currencyArrayNames)
        spinnerTo.adapter = spinnerToAdapter

    }

    private fun quoteValue(spinner: Spinner): Double {

        val spinnerValue = spinner.selectedItem.toString()

        val value = getCurrencyValues(spinnerValue, currencyNameList, currencyQuotesList)

        return value as Double
    }

    private fun calculate() {



            calculateButton.setOnClickListener {

                val fromValue = quoteValue(spinnerFrom)
                val toValue = quoteValue(spinnerTo)

                when (amount.text.toString()) {

                    "" -> Toast.makeText(
                        applicationContext,
                        "Type an amount to exchange",
                        Toast.LENGTH_LONG
                    )
                        .show()

                    else -> {

                        val amountValue = amount.text.toString().toDouble()
                        exchange.text = getQuote(fromValue, toValue, amountValue).toString()

                        currentCurrency.text =
                            getCurrencyCode(spinnerTo.selectedItem.toString(), currencyNameList)

                    }
                }

            }

    }

    private fun getQuote(n1: Double, n2: Double, amount: Double): Double {

        var quote = n2 / n1 * amount
        quote *= 100

        var round = quote.roundToInt().toDouble()
        round /= 100

        return round
    }

    fun getCurrencyCode(char: String, array: ArrayList<MappingObject>): String {

        currencyNameList?.let {
            currencyNameList.forEach {
                Log.d(
                    "CURRENCY NAME/CODE LIST",
                    "Key: ${it.key} | Value: ${it.value}"
                )
            }
        }

        return searchKeys(char, array)

    }

    private fun allCurrencies() {

        allCurrenciesButton.setOnClickListener {

            val intent = Intent(this, CurrenciesActivity::class.java)
            it.context.startActivity(intent)
        }
    }

}





