package br.net.easify.currencydroid.viewmodel

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import br.net.easify.currencydroid.MainApplication
import br.net.easify.currencydroid.api.CurrencyService
import br.net.easify.currencydroid.api.QuoteService
import br.net.easify.currencydroid.database.AppDatabase
import br.net.easify.currencydroid.database.model.Currency
import javax.inject.Inject

class CurrenciesViewModel (application: Application) : AndroidViewModel(application) {

    val currencies by lazy { MutableLiveData<List<Currency>>() }


    @Inject
    lateinit var database: AppDatabase

    init {
        (getApplication() as MainApplication).getAppComponent()?.inject(this)
        loadCurrencies()
    }

    private fun loadCurrencies() {
        currencies.value = database.currencyDao().getAll()
    }
}