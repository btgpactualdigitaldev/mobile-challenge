package com.br.btg.ui.viewmodels

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.br.btg.data.models.ConverterModel
import com.br.btg.data.models.Currency
import com.br.btg.data.models.CurrencyLayerModel
import com.br.btg.data.repositories.CurrencyLayerRepository
import com.br.btg.data.repositories.Resource

class ConversorViewModel(private val repository: CurrencyLayerRepository) : ViewModel() {

    private val currencies: MutableLiveData<Map<String, String>> = MutableLiveData<Map<String, String>>()
    private var coins: MutableList<Currency> = ArrayList<Currency>()
    private var goToNavigationID: String = "";
    private var currencyOrigem: MutableLiveData<String> = MutableLiveData<String>()
    private var currencyDestination: MutableLiveData<String> = MutableLiveData<String>()

    fun getNameCurrencies(): MutableList<Currency> {
        return coins
    }

    fun getCurrencies(): MutableLiveData<Map<String, String>> {
        return currencies
    }

    fun setCurrencies(currencie: Map<String, String>? ) {
        currencie?.map { map -> coins.add(Currency(map.key, map.value))  }
        currencies.postValue(currencie)
    }

    fun getAllCurrencies(context: Context): LiveData<Resource<CurrencyLayerModel?>> {
        return repository.getAllCurrencies(context)
    }

    fun converterPrice(valueOrigem: String, valueDestiny: String, ammount: String): LiveData<Resource<ConverterModel>> {
       return repository.converter(valueDestiny, valueOrigem, ammount)
    }


    fun setCurrencyOrigem(origem: String) { currencyOrigem.value = origem }

    fun getCurrencyOrigem(): MutableLiveData<String> { return currencyOrigem }

    fun setCurrencyDestination(destination: String) { currencyDestination.value = destination }

    fun getCurrencyDestination():  MutableLiveData<String> { return currencyDestination }

    fun setNavigationId(id: String) { goToNavigationID = id }

    fun getNavigationId(): String { return goToNavigationID }

    fun getLocalStore(context: Context): CurrencyLayerModel? {
        return repository.getObject(context)
    }

}
