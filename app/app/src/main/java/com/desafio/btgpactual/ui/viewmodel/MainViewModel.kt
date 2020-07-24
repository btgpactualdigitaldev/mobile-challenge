package com.desafio.btgpactual.ui.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.desafio.btgpactual.repositories.CurrencyRepository
import com.desafio.btgpactual.repositories.QuoteRepository
import com.desafio.btgpactual.shared.models.CurrencyModel
import com.desafio.btgpactual.shared.models.QuotesModel

class MainViewModel(
    private val repositoryCurrency: CurrencyRepository,
    private val repositoryQuote: QuoteRepository
) : ViewModel() {

    fun callCurrencies(): LiveData<List<CurrencyModel>> {
        val liveData = MutableLiveData<List<CurrencyModel>>()
        repositoryCurrency.callCurrencies(
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

    fun callQuotes(): LiveData<List<QuotesModel>> {
        val liveData = MutableLiveData<List<QuotesModel>>()
        repositoryQuote.callQuotes(
            sucess = {
                liveData.value = it
            }, error =  {

            }
        )
        return liveData
    }

}