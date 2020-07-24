package com.desafio.btgpactual.ui.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.desafio.btgpactual.repositories.CurrencyRepository
import com.desafio.btgpactual.shared.models.CurrencyModel

class AvailableCurrenciesViewModel(
    private val repository: CurrencyRepository
): ViewModel() {
    fun callCurrencies(): LiveData<List<CurrencyModel>> {
        val liveData = MutableLiveData<List<CurrencyModel>>()
        repository.callCurrencies(
            sucess = {
                val codes = it
                    .sortedBy { currencyModel ->
                        currencyModel.code
                    }
                liveData.value = codes
            },
            error = {}
        )
        return liveData
    }
}