package br.dev.infra.btgconversiontool.ui.currencies

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import br.dev.infra.btgconversiontool.data.CurrencyView
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class CurrenciesViewModel @Inject constructor(
    private val repository: CurrenciesRepository
) : ViewModel() {

    private val _currenciesList = MutableLiveData<List<CurrencyView>>()
    private lateinit var currencyQuery: List<CurrencyView>
    var currenciesList: LiveData<List<CurrencyView>> = _currenciesList

    private suspend fun getAllCurrenciesQuotes() {
        currencyQuery = repository.getCurrencies()
        _currenciesList.value = currencyQuery
    }

    init {
        viewModelScope.launch {
            getAllCurrenciesQuotes()
        }
    }

    fun queryList(query: String?) {

        val filterList = currencyQuery.filter {
            it.description.plus(it.id).lowercase().contains(query?.lowercase() as CharSequence)
        }

        _currenciesList.value = filterList
    }

}