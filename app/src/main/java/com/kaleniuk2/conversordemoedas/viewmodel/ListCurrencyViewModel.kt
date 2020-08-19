package com.kaleniuk2.conversordemoedas.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.kaleniuk2.conversordemoedas.data.DataWrapper
import com.kaleniuk2.conversordemoedas.data.model.Currency
import com.kaleniuk2.conversordemoedas.data.repository.CurrencyRepository
import com.kaleniuk2.conversordemoedas.data.repository.CurrencyRepositoryImpl

class ListCurrencyViewModel(
    private val repository: CurrencyRepository = CurrencyRepositoryImpl()) : ViewModel() {

    val showLoading: MutableLiveData<Boolean> = MutableLiveData()
    val showError: MutableLiveData<String> = MutableLiveData()
    val showListCurrencies: MutableLiveData<List<Currency>> = MutableLiveData()
    private var listCurrency: List<Currency> = listOf()
    private var currentOrder: ORDER? = null

    enum class ORDER {
        DESC, ASC
    }

    fun interact(interact: Interact) {
        when (interact) {
            is Interact.GetCurrencies -> getCurrencies()
            is Interact.SearchCurrency -> searchCurrency(interact.search)
            is Interact.OrderCurrencies -> orderCurrencies()
        }
    }

    private fun searchCurrency(search: String) {
        if (search.isEmpty())
            showListCurrencies.value = listCurrency
        else
        showListCurrencies.value = listCurrency.filter {
            it.abbreviation.toLowerCase().contains(search.toLowerCase())
                    || it.name.toLowerCase().contains(search.toLowerCase())
        }
    }

    private fun getCurrencies() {
        showLoading.value = true
        repository.getListCurrency {
            showLoading.value = false
            when (it) {
                is DataWrapper.Success -> {
                    showListCurrencies.value = it.value
                    listCurrency = it.value
                }
                is DataWrapper.Error -> showError.value = it.error
            }
        }
    }

    private fun orderCurrencies() {
        if (currentOrder == null || currentOrder == ORDER.DESC) {
            currentOrder = ORDER.ASC

            showListCurrencies.value = showListCurrencies.value?.sortedBy { it.name }
        } else {
            currentOrder = ORDER.DESC

            showListCurrencies.value = showListCurrencies.value?.sortedByDescending { it.name }
        }
    }

    sealed class Interact {
        object GetCurrencies : Interact()
        object OrderCurrencies : Interact()
        class SearchCurrency(val search: String) : Interact()
    }
}