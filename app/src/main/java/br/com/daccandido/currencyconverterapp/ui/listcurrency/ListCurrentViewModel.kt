package br.com.daccandido.currencyconverterapp.ui.listcurrency

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.ResultRequest
import br.com.daccandido.currencyconverterapp.data.database.CurrencyDAO
import br.com.daccandido.currencyconverterapp.data.model.Currency
import br.com.daccandido.currencyconverterapp.data.model.ExchangeRate
import br.com.daccandido.currencyconverterapp.data.repository.CurrencyData
import br.com.daccandido.currencyconverterapp.ui.base.BaseViewModel
import io.realm.RealmResults
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class ListCurrentViewModel(private val currencyData: CurrencyData, private val currencyDAO: CurrencyDAO): BaseViewModel() {

    val listCurrency: MutableLiveData<ExchangeRate> = MutableLiveData()

    fun getList() {
        CoroutineScope(Dispatchers.Main).launch {
            isLoading.value = true
            currencyData.getListExchangeRate { result ->
                when (result) {
                    is ResultRequest.SuccessExchangeRate -> {
                        val quote = result.exchangeRate
                        for (quoteMap in quote.currencies) {
                            val currency = Currency(
                                code = quoteMap.key,
                                name = quoteMap.value
                            )
                            CoroutineScope(Dispatchers.IO).launch {
                                currencyDAO.insertOrUpdate(currency) {}
                            }
                        }
                        isLoading.value = false
                        listCurrency.value = result.exchangeRate
                    }
                    is ResultRequest.Error -> {
                        error.value = result.error
                    }
                    is ResultRequest.SeverError -> {
                        error.value = R.string.error_not_exchange_rates
                    }
                }
            }
        }
    }

    fun getListLocal(sort: String) : RealmResults<Currency> {
        return currencyDAO.getAllCurrencies(sort)
    }

    fun searchItem(sort: String, filter:String): RealmResults<Currency>{
        return  currencyDAO.searchCurrency( sort, filter)
    }

    class ViewModelFactory(private val currencyData: CurrencyData, private val currencyDAO: CurrencyDAO) : ViewModelProvider.Factory {
        @Suppress("UNCHECKED_CAST")
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            if (modelClass.isAssignableFrom(ListCurrentViewModel::class.java)) {
                return ListCurrentViewModel(currencyData, currencyDAO) as T
            }
            throw IllegalArgumentException("Unknown ViewModel class")
        }
    }
}