package com.btg.convertercurrency.features.currency_converter.view

import android.app.Application
import android.text.Editable
import android.text.TextWatcher
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.OnLifecycleEvent
import androidx.lifecycle.viewModelScope
import com.btg.convertercurrency.base.BaseViewModel
import com.btg.convertercurrency.data_local.RepositoryCurrencyLayerLocal
import com.btg.convertercurrency.data_local.RepositorySettingsLocal
import com.btg.convertercurrency.data_local.entity.SettingsDb
import com.btg.convertercurrency.data_network.repository.RepositoryCurrencyLayerNetwork
import com.btg.convertercurrency.features.base_entity.CurrencyItem
import com.btg.convertercurrency.features.base_entity.QuoteItem
import com.btg.convertercurrency.features.currency_converter.entity.CurrencyParameters
import com.btg.convertercurrency.features.currency_converter.entity.CurrencyType
import com.btg.convertercurrency.features.util.Event
import com.btg.convertercurrency.features.util.GenericConverterCurrencyException
import com.btg.convertercurrency.features.util.default
import com.btg.convertercurrency.features.util.getMamipuladeEvent
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.time.OffsetDateTime

class CurrencyConverterViewModel(
    application: Application,
    private val settingsLocal: RepositorySettingsLocal,
    private val currencyLayerLocal: RepositoryCurrencyLayerLocal,
    private val currencyLayerNetwork: RepositoryCurrencyLayerNetwork
) : BaseViewModel<Any>(application) {

    private val currencyTransformer = CurrencyParameters().apply {
        if (to.quotesList.isEmpty())
            to.quotesList.add(QuoteItem(code = "", quote = "1"))
        if (from.quotesList.isEmpty())
            from.quotesList.add(QuoteItem(code = "", quote = "1"))
    }

    val liveDataCurrencyTransformer =
        MutableLiveData<CurrencyParameters>().default(currencyTransformer)

    val liveDataCurrencyFrom = MutableLiveData<String>().default("0.0")

    val showPopupUpSelecCurrency = MutableLiveData<Event<List<CurrencyItem>>>()

    @OnLifecycleEvent(Lifecycle.Event.ON_CREATE)
    fun updateDataLocal() {

        viewModelScope.launch(context = Dispatchers.IO) {
            try {
                loadingLiveData.postValue(Event(true).getMamipuladeEvent())

                val settingsDb = settingsLocal.getSettigs()
                settingsUpdated(settingsDb)
                settingsSetCurrency(settingsDb)

                loadingLiveData.postValue(Event(false).getMamipuladeEvent())

            } catch (exeption: Exception) {
                if (exeption is GenericConverterCurrencyException) {
                    errorLiveData.postValue(Event(exeption.codeError).getMamipuladeEvent())
                }
            }
        }
    }

    private suspend fun settingsUpdated(settingsDb: Array<SettingsDb>) {
        settingsDb.forEach { settingsDb ->
            if (settingsDb.key == SettingsDb.getUpdated().key && settingsDb.value == false.toString()) {
                insertCurrencyAndQuoties()
            }
        }
    }

    private suspend fun settingsSetCurrency(settingsDb: Array<SettingsDb>) {
        settingsDb.forEach {
            if (it.key == SettingsDb.getFromCurrency().key) {
                val currencyItem = currencyLayerLocal.getCurrencyByCode(it.value)
                setToCurrency(currencyItem, CurrencyType.FROM)
            }

            if (it.key == SettingsDb.getToCurrency().key) {
                val currencyItem = currencyLayerLocal.getCurrencyByCode(it.value)
                setToCurrency(currencyItem, CurrencyType.TO)
            }
        }
    }

    private suspend fun insertCurrencyAndQuoties() {

        val listCurrencyItem = currencyLayerNetwork.listCurrencies()
        val listQuoties = currencyLayerNetwork.listQuotes()

        //insere o codigo da currency pai no quote
        val listQuoteItem = listCurrencyItem
            .map { currencyItem ->
                listQuoties
                    .filter { it.code == currencyItem.code }[0]
                    .apply {
                        currencyItem.lastUpdate = this.date
                        this.currencyId = currencyItem.name.hashCode().toLong()
                    }
            }

        currencyLayerLocal.insertCurrncy(listCurrencyItem)

        currencyLayerLocal.insertQuoties(listQuoteItem)

        settingsLocal.updateSettigs(true.toString(), SettingsDb.getUpdated().key)
    }

    fun updateQuoties() {
        viewModelScope.launch(context = Dispatchers.IO) {
            try {

                if (refreshValidation()) {
                    throw GenericConverterCurrencyException(
                        303, "As cotacoes ja estao atualizada para esse periodo."
                    )
                }

                loadingLiveData.postValue(Event(true).getMamipuladeEvent())

                val listCurrencyItem = currencyLayerLocal.listCurrencies()
                val listQuoties = currencyLayerNetwork.listQuotes()
                var lastUpdate = OffsetDateTime.now()

                //insere o codigo da currency pai no quote
                val listQuoteItem = listCurrencyItem
                    .map { currencyItem ->
                        listQuoties
                            .filter { it.code == currencyItem.code }[0]
                            .apply {
                                lastUpdate = this.date
                                this.currencyId = currencyItem.name.hashCode().toLong()
                            }
                    }

                currencyLayerLocal.insertQuoties(listQuoteItem)

                currencyLayerLocal.upDateFieldLastUpdate(lastUpdate)

                loadingLiveData.postValue(Event(false).getMamipuladeEvent())

            } catch (exeption: Exception) {
                if (exeption is GenericConverterCurrencyException) {
                    errorLiveData.postValue(Event(exeption.codeError).getMamipuladeEvent())
                }
            }
        }
    }

    private fun refreshValidation(): Boolean {
        return OffsetDateTime.now().dayOfWeek == currencyTransformer.to.lastUpdate.dayOfWeek
    }

    fun showPopupUpSelectCurrency() {
        viewModelScope.launch {
            val list = currencyLayerLocal.listCurrenciesWithQuoties()
            showPopupUpSelecCurrency.postValue(Event(list))
        }
    }

    fun valueCurrency(value: String) {
        currencyTransformer
            .apply { this.value = value }
            .run {
                liveDataCurrencyFrom.postValue(convertFromCurrencyForToCurrence())
            }
    }

    fun setToCurrency(currencyItem: CurrencyItem, currencyType: CurrencyType) {
        when (currencyType) {
            CurrencyType.TO -> {
                currencyTransformer.to.apply {
                    code = currencyItem.code
                    name = currencyItem.name
                    lastUpdate = currencyItem.lastUpdate
                    quotesList.apply {
                        clear()
                        addAll(currencyItem.quotesList)
                    }
                }
            }
            CurrencyType.FROM -> {
                currencyTransformer.from.apply {
                    code = currencyItem.code
                    name = currencyItem.name
                    lastUpdate = currencyItem.lastUpdate
                    quotesList.apply {
                        clear()
                        addAll(currencyItem.quotesList)
                    }
                }
            }
        }
        liveDataCurrencyTransformer.postValue(currencyTransformer)
        currencyTransformer
            .run {
                liveDataCurrencyFrom.postValue(convertFromCurrencyForToCurrence())
            }
    }

    fun convertCurrency(): TextWatcher {
        return object : TextWatcher {
            override fun afterTextChanged(p0: Editable?) {}

            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
            }

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
                valueCurrency(p0.toString())
            }
        }
    }
}