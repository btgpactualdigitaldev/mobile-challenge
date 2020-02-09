package com.alexandreac.mobilechallenge.viewmodel

import android.app.Application
import androidx.lifecycle.*
import com.alexandreac.mobilechallenge.R
import com.alexandreac.mobilechallenge.model.data.Currency
import com.alexandreac.mobilechallenge.model.datasource.ICurrencyDataSource

class CurrencyListViewModel(val repository: ICurrencyDataSource, application: Application):
                            AndroidViewModel(application), LifecycleObserver{
    val currencies = MutableLiveData<List<Currency>>().apply { value = emptyList() }
    val loadingVisibility = MutableLiveData<Boolean>().apply { value = false }
    val message = MutableLiveData<String>().apply { value = "" }
    var items: List<Currency> = emptyList()

    @OnLifecycleEvent(Lifecycle.Event.ON_START)
    fun load(){
        loadingVisibility.postValue(true)
        message.postValue("")
        repository.listAll({items ->
            this.items = items
            currencies.postValue(items.toMutableList())
            if (items.isEmpty()){
                message.postValue(getApplication<Application>().getString(R.string.currencies_not_found))
            }
            loadingVisibility.postValue(false)
        },{
            loadingVisibility.postValue(false)
            message.postValue(it)
        })
    }

    fun orderListByInitials(){
        currencies.postValue(items.sortedBy { it.initials })
    }

    fun orderListByName(){
        currencies.postValue(items.sortedBy { it.name })
    }

    fun search(search:String){
        currencies.postValue(items.filter { it.initials.toLowerCase().contains(search.toLowerCase())
                || it.name.toLowerCase().contains(search.toLowerCase()) })
    }
}