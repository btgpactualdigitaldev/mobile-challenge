package com.gui.antonio.testebtg.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModel
import com.gui.antonio.testebtg.data.Currencies
import com.gui.antonio.testebtg.data.Quotes
import com.gui.antonio.testebtg.repository.IAppRepository
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.math.BigDecimal

open class MainViewModel(private val repository: IAppRepository) : ViewModel(), IMainViewModel {
    override fun getListCurrency(): LiveData<List<Currencies>> = repository.getListCurrency()
    override fun getListCurrencyOffline(): LiveData<List<Currencies>> = repository.getListCurrencyOffline()
    override fun getQuote(symbol: String): LiveData<Quotes> = repository.getQuote(symbol)
    override fun deleteAndInsertQuotes(symbol: List<String>) = repository.deleteAndInsertQuotes(symbol)
    override fun getQuoteOffline(symbol: String): LiveData<Quotes> = repository.getQuoteOffline(symbol)
    override fun convert(valueUser: Double, valueCoin: Double): Double = valueUser * valueCoin
}