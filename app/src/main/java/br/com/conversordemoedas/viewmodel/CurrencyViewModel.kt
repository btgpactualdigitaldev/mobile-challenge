package br.com.conversordemoedas.viewmodel

import androidx.lifecycle.ViewModel
import br.com.conversordemoedas.model.*
import br.com.conversordemoedas.model.List
import retrofit2.Callback
import java.math.RoundingMode
import java.text.DecimalFormat

class CurrencyViewModel(val quotesManager: QuotesManager, val liveManager: LiveManager, val listManager: ListManager): ViewModel() {

    fun formatValue(value: Double): String{
        val df = DecimalFormat("#.##")
        df.roundingMode = RoundingMode.CEILING

        return df.format(value)
    }

    fun createQuotes(live: Live) = quotesManager.createQuotes(live)

    fun getDateTime(timestamp: String) = liveManager.getDateTime(timestamp)

    fun getCurrencyLive(currenciesCodes: String, callback: Callback<Live>) = liveManager.getCurrencyLive(currenciesCodes, callback)

    fun getCurrencyList(callback: Callback<List>) = listManager.getCurrencyList(callback)

    fun createCurrencyList(list: List) = listManager.createCurrencyList(list)



}