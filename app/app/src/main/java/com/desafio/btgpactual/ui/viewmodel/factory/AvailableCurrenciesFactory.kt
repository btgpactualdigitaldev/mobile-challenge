package com.desafio.btgpactual.ui.viewmodel.factory

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.desafio.btgpactual.repositories.CurrencyRepository
import com.desafio.btgpactual.ui.viewmodel.AvailableCurrenciesViewModel


@Suppress("UNCHECKED_CAST") class AvailableCurrenciesFactory(
    private val repository: CurrencyRepository
): ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        return AvailableCurrenciesViewModel(repository) as T
    }
}