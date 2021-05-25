package br.com.btg.test.feature.currency.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import br.com.btg.test.data.Resource
import br.com.btg.test.feature.currency.business.ListCurrenciesUseCase
import br.com.btg.test.feature.currency.persistence.CurrencyEntity
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class CurrenciesListViewModel(private val listCurrenciesUseCase: ListCurrenciesUseCase) :
    ViewModel() {

    private val _listResult = MutableLiveData<Resource<List<CurrencyEntity>>>()

    val listResult: LiveData<Resource<List<CurrencyEntity>>> = _listResult

    fun retrieveCurrencies() {
        viewModelScope.launch {
            _listResult.value = Resource.loading()
            listCurrenciesUseCase.invoke(null)
                .catch { e ->
                    _listResult.value = Resource.error(e.message ?: "error")
                }
                .collect { value ->
                    _listResult.value = value
                }
        }
    }
}