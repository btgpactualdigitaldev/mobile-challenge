package br.com.andreldsr.btgcurrencyconverter.presenter.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency
import br.com.andreldsr.btgcurrencyconverter.domain.repositories.CurrencyRepository
import br.com.andreldsr.btgcurrencyconverter.domain.usecases.GetQuoteFromUsdImpl
import br.com.andreldsr.btgcurrencyconverter.domain.usecases.ListCurrency
import br.com.andreldsr.btgcurrencyconverter.domain.usecases.ListCurrencyImpl
import br.com.andreldsr.btgcurrencyconverter.infra.repositories.CurrencyRepositoryImpl
import br.com.andreldsr.btgcurrencyconverter.mock.CurrencyMockRepositoryImpl
import kotlinx.coroutines.launch

class CurrencyConversionViewModel(private val repository: CurrencyRepository) : ViewModel() {
    val currencyLiveData: MutableLiveData<List<Currency>> = MutableLiveData()
    val currencyFrom: MutableLiveData<Currency> = MutableLiveData(initialCurrencyFrom)
    val currencyTo: MutableLiveData<Currency> = MutableLiveData(initialCurrencyTo)
    private val currencyFromValue: MutableLiveData<Float> = MutableLiveData(1f)
    val currencyToValue: MutableLiveData<Float> = MutableLiveData(0f)
    val quote: MutableLiveData<Float> = MutableLiveData(1f)

    fun loadQuote(){
        val getQuote = GetQuoteFromUsdImpl(repository)
        viewModelScope.launch {
            val from = currencyFrom.value?.initials ?: ""
            val to = currencyTo.value?.initials ?: ""
            quote.value = getQuote.getQuote(from, to)
        }
    }

    fun calculate(to: Float) {
        currencyFromValue.value = to
        currencyToValue.value = currencyFromValue.value!! * quote.value!!
    }

    fun swapCurrencies() {
        val currencyAux = currencyFrom.value
        currencyFrom.value = currencyTo.value
        currencyTo.value = currencyAux
        currencyToValue.value = 0f
        loadQuote()
    }

    fun getCurrencies() {
        val listCurrency: ListCurrency = ListCurrencyImpl(repository)
        viewModelScope.launch {
            currencyLiveData.value = listCurrency.getList()
        }
    }


    companion object {
        var initialCurrencyFrom = Currency(initials = "CAD", name = "Canadian Dollar")
        var initialCurrencyTo = Currency(initials = "BRL", name = "Brazilian Real")

    }

    class ViewModelFactory() : ViewModelProvider.Factory {
        private val repository = CurrencyRepositoryImpl.build()
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            if (modelClass.isAssignableFrom(CurrencyConversionViewModel::class.java)) return CurrencyConversionViewModel(repository) as T
            throw IllegalArgumentException("Unknown ViewModel class")
        }
    }
}