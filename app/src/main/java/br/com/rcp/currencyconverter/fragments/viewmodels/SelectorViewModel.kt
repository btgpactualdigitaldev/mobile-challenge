package br.com.rcp.currencyconverter.fragments.viewmodels

import android.app.Application
import androidx.databinding.ObservableArrayList
import androidx.databinding.ObservableBoolean
import androidx.lifecycle.AndroidViewModel
import br.com.rcp.currencyconverter.Converter
import br.com.rcp.currencyconverter.database.entities.Currency
import br.com.rcp.currencyconverter.fragments.viewmodels.base.BaseViewModel
import br.com.rcp.currencyconverter.repository.CurrenciesRepository
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class SelectorViewModel(application: Application) : BaseViewModel(application) {
    private	val	repository : CurrenciesRepository by lazy { Converter.component.getCurrenciesRepository() }
    var currencies  = ObservableArrayList<Currency>()
    val fetching    = ObservableBoolean(false)

    override fun onServiceError() {
        CoroutineScope(Dispatchers.Main).launch {
            fetching.set(false)
            super.onServiceError()
        }
    }

    fun fetch() {
        setLoading()
        CoroutineScope(Dispatchers.IO).launch {
            repository.getCurrencies().apply {
                CoroutineScope(Dispatchers.Main).launch {
                    currencies.addAll(this@apply)
                    setNotLoading()
                }
            }
        }
    }
}