package br.com.btg.btgchallenge.ui.fragments.currencylist

import androidx.lifecycle.*
import br.com.btg.btgchallenge.network.api.config.Resource
import br.com.btg.btgchallenge.network.api.config.Status
import br.com.btg.btgchallenge.network.api.currencylayer.CurrencyLayerRepository
import br.com.btg.btgchallenge.network.model.ApiResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.lang.Exception

class CurrencyListViewModel(val currencyLayerRepository: CurrencyLayerRepository) : ViewModel() {

    val getCurrencies= MutableLiveData<Resource<Any>>()

    fun getCurrencies() {
        viewModelScope.launch(context = Dispatchers.IO)
        {
            getCurrencies.postValue(Resource.loading())
            val currencies = currencyLayerRepository.getCurrencies()
            when (currencies.status) {
                Status.SUCCESS -> {
                    //persistir dado
                }
            }
            getCurrencies.postValue(currencies)
        }
    }
}