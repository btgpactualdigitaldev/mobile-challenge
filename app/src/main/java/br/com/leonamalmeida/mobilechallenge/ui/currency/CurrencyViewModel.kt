package br.com.leonamalmeida.mobilechallenge.ui.currency

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MediatorLiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Transformations
import androidx.lifecycle.ViewModel
import br.com.leonamalmeida.mobilechallenge.data.Result
import br.com.leonamalmeida.mobilechallenge.util.SingleLiveEvent
import br.com.leonamalmeida.mobilechallenge.data.Currency
import br.com.leonamalmeida.mobilechallenge.data.repositories.CurrencyRepository

/**
 * Created by Leo Almeida on 27/06/20.
 */
class CurrencyViewModel @ViewModelInject constructor(private val repository: CurrencyRepository) :
    ViewModel() {

    private val fetchEvent = MutableLiveData<FetchEvent>()
    val onSelectedCurrencyEvent = SingleLiveEvent<Currency>()

    private val data = Transformations.switchMap(fetchEvent) {
        when (it) {
            is FetchEvent.Network -> repository.getCurrencies(true, "", false)
            is FetchEvent.SearchBy -> repository.getCurrencies(false, it.keyword, it.orderByName)
        }
    }

    val currencies = MediatorLiveData<List<Currency>>().apply {
        addSource(data) { if (it is Result.Success) value = it.value }
    }

    val error = MediatorLiveData<Int>().apply {
        addSource(data) { if (it is Result.Error) value = it.msg }
    }

    val loading = MediatorLiveData<Boolean>().apply {
        addSource(data) { if (it is Result.Loading) value = it.isLoading }
    }

    fun getCurrencies() {
        fetchEvent.value = FetchEvent.Network
    }

    fun onSelectedCurrency(currency: Currency) {
        onSelectedCurrencyEvent.value = currency
    }

    fun searchCurrency(keyToSearch: String) {
        if (fetchEvent.value is FetchEvent.SearchBy)
            fetchEvent.value =
                (fetchEvent.value as FetchEvent.SearchBy).copy(keyword = keyToSearch)
        else fetchEvent.value = FetchEvent.SearchBy(keyToSearch, false)
    }

    fun orderBy(keyToSearch: String, orderByName: Boolean) {
        if (fetchEvent.value is FetchEvent.SearchBy)
            fetchEvent.value =
                (fetchEvent.value as FetchEvent.SearchBy).copy(orderByName = orderByName)
        else fetchEvent.value = FetchEvent.SearchBy(keyToSearch, orderByName)
    }

    sealed class FetchEvent {
        data class SearchBy(val keyword: String, val orderByName: Boolean) : FetchEvent()
        object Network : FetchEvent()
    }
}