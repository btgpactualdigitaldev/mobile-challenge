package br.com.gft.main

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import br.com.gft.main.interactor.GetCurrencyListUseCase
import br.com.gft.main.iteractor.model.Currency
import kotlinx.coroutines.launch

class PickCurrencyViewModel (private val getCurrencyListUseCase: GetCurrencyListUseCase) : ViewModel(){
    val currencyListLiveData: MutableLiveData<List<Currency>> = MutableLiveData()
    val errorLiveData: MutableLiveData<String> = MutableLiveData()
    val loadingLiveData: MutableLiveData<Boolean> = MutableLiveData()

    init {
        fetch()
    }

    fun fetch() {
        loadingLiveData.postValue(true)
        viewModelScope.launch {
            val response = getCurrencyListUseCase(Unit)

            loadingLiveData.postValue(false)
            when (response.status) {
                Resource.Status.SUCCESS -> {
                    response.data?.let {
                        errorLiveData.postValue("")
                        currencyListLiveData.postValue(it)
                    }
                }
                Resource.Status.ERROR -> {
                    response.exception?.let{
                        errorLiveData.postValue(it.message)
                    }
                }
            }
        }
    }
}