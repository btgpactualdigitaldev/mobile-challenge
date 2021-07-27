package io.felipeandrade.currencylayertest.ui.currency.selection

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.liveData
import io.felipeandrade.currencylayertest.usecase.LoadSupportedCurrenciesUseCase
import io.felipeandrade.domain.CurrencyModel
import kotlinx.coroutines.Dispatchers

class CurrencySelectionViewModel(
    private val loadSupportedCurrencies: LoadSupportedCurrenciesUseCase
) : ViewModel() {

    val selectedCurrency = MutableLiveData<CurrencyModel>()

    val searchQuery = MutableLiveData<String>()

    val characterList: LiveData<List<CurrencyModel>> = liveData(Dispatchers.IO) {
        val retrievedData = loadSupportedCurrencies()
        emit(retrievedData)
    }

    fun itemClicked(currency: CurrencyModel) {
        selectedCurrency.postValue(currency)
    }

    fun searchFieldUpdated(query: String) {
        searchQuery.postValue(query)
    }

}