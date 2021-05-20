package br.com.albertomagalhaes.btgcurrencies.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import br.com.albertomagalhaes.btgcurrencies.repository.CurrencyRepository
import com.btgpactual.currencyconverter.data.framework.retrofit.ClientAPI
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class SetupViewModel(private val currencyRepository: CurrencyRepository) : ViewModel() {

    val synchronizeCurrencyListStatus = MutableLiveData<ClientAPI.ResponseType>()

    fun synchronizeCurrencyList() = GlobalScope.launch(Dispatchers.Main) {
        synchronizeCurrencyListStatus.postValue(currencyRepository.synchronizeCurrencyList())
    }

    fun hasCurrencyList(onSuccess: (Boolean) -> Unit) = GlobalScope.launch(Dispatchers.Main) {
        onSuccess.invoke(currencyRepository.hasCurrencyList())
    }
}