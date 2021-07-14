package com.sugarspoon.desafiobtg.ui.coins

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.sugarspoon.data.local.repositories.RepositoryLocal

class CurrencyViewModel(
    private val repositoryLocal: RepositoryLocal
) : ViewModel() {

    var currencies = repositoryLocal.allCurrencies

    @Suppress("UNCHECKED_CAST")
    class Factory constructor(
        private val repositoryLocalLocal: RepositoryLocal
    ) : ViewModelProvider.NewInstanceFactory() {
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            return CurrencyViewModel(
                repositoryLocal = repositoryLocalLocal
            ) as T
        }
    }
}
