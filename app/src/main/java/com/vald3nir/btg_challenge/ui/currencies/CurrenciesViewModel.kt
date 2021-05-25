package com.vald3nir.btg_challenge.ui.currencies

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.vald3nir.btg_challenge.core.base.BaseViewModel
import com.vald3nir.btg_challenge.items_view.CurrencyItemView
import com.vald3nir.btg_challenge.mapper.toCurrenciesItemView
import com.vald3nir.data.repository.DataRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class CurrenciesViewModel(private val dataRepository: DataRepository) : BaseViewModel() {

    private val _error = MutableLiveData<Unit>()
    val error: LiveData<Unit> = _error

    private val _list = MutableLiveData<List<CurrencyItemView>>()
    val list: LiveData<List<CurrencyItemView>> = _list

    private val _listFiltered = MutableLiveData<List<CurrencyItemView>>()
    val listFiltered: LiveData<List<CurrencyItemView>> = _listFiltered

    fun loadCurrencies() {
        launch {

            var list: List<CurrencyItemView>?

            withContext(Dispatchers.IO) {
                list = dataRepository.listCurrencies().toCurrenciesItemView()
            }

            if (list.isNullOrEmpty()) {
                _error.postValue(Unit)

            } else {
                _list.postValue(list!!)
            }
        }
    }

    fun searchCurrencies(searchText: String?) {
        if (!searchText.isNullOrBlank()) launch {

            var listFiltered: List<CurrencyItemView>?

            withContext(Dispatchers.IO) {
                listFiltered = list.value?.filter {
                    (it.code + it.description).toUpperCase().contains(searchText.toUpperCase())
                }
            }

            if (listFiltered.isNullOrEmpty()) {
                _error.postValue(Unit)

            } else {
                _listFiltered.postValue(listFiltered!!)
            }

        } else {
            loadCurrencies()
        }
    }
}