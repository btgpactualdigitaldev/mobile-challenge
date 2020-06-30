package br.com.daccandido.currencyconverterapp.ui.convertcurrency

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.ResultRequest
import br.com.daccandido.currencyconverterapp.data.database.CurrencyDAO
import br.com.daccandido.currencyconverterapp.data.model.Currency
import br.com.daccandido.currencyconverterapp.data.model.QuoteRequest
import br.com.daccandido.currencyconverterapp.data.repository.CurrencyData
import br.com.daccandido.currencyconverterapp.ui.base.BaseViewModel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class ConvertCurresncyViewModel(private val currencyData: CurrencyData, private val currencyDAO: CurrencyDAO): BaseViewModel() {

    val quotes: MutableLiveData<QuoteRequest> = MutableLiveData()

    fun getQuote(currenciyes: String) {
        CoroutineScope(Dispatchers.Main).launch {
            isLoading.value = true
            currencyData.getQuote(currenciyes) { result ->
                when (result) {
                    is ResultRequest.SuccessQuote -> {
                        for (quoteMap in result.quoteRequest.quotes) {
                            val currency = Currency(
                                code = quoteMap.key.substring(3),
                                quote = quoteMap.value
                            )
                            CoroutineScope(Dispatchers.IO).launch {
                                currencyDAO.insertOrUpdate(currency) {}
                            }
                        }
                        isLoading.value = false
                        quotes.value = result.quoteRequest
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

    fun getCurrency(field: String, value: String) : Currency?{
        return currencyDAO.getCurrency(field, value)
    }

    class ViewModelFactory(private val currencyData: CurrencyData, private val currencyDAO: CurrencyDAO) : ViewModelProvider.Factory {
        @Suppress("UNCHECKED_CAST")
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            if (modelClass.isAssignableFrom(ConvertCurresncyViewModel::class.java)) {
                return ConvertCurresncyViewModel(currencyData,currencyDAO) as T
            }
            throw IllegalArgumentException("Unknown ViewModel class")
        }
    }
}