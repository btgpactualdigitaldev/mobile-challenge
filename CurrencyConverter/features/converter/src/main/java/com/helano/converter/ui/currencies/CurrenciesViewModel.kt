package com.helano.converter.ui.currencies

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.helano.repository.CurrencyRepository
import com.helano.shared.model.Currency
import com.helano.shared.util.Preferences
import kotlinx.coroutines.launch

class CurrenciesViewModel @ViewModelInject constructor(
    private val repository: CurrencyRepository,
    private val prefs: Preferences
) : ViewModel() {

    val items by lazy { MutableLiveData<List<Currency>>() }
    val isAscending by lazy { MutableLiveData<Boolean>() }
    val selectedCurrency by lazy { MutableLiveData<String>() }

    fun start() {
        viewModelScope.launch {
            isAscending.value = prefs.isAscending
            items.value = repository.currencies()
            sortList()
        }
    }

    fun onCurrencySelected(code: String) {
        selectedCurrency.value = code
    }

    fun onSortChanged() {
        isAscending.apply { value = value?.not() }
        prefs.isAscending = isAscending.value!!
        sortList()
    }

    private fun sortList() {
        val list = if (prefs.isAscending) {
            items.value!!.sortedBy {
                it.code
            }
        } else {
            items.value!!.sortedByDescending {
                it.code
            }
        }

        items.value = list
    }
}