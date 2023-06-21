package com.btg.convertercurrency.features.currency_list.view

import android.app.Application
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.OnLifecycleEvent
import androidx.lifecycle.viewModelScope
import com.btg.convertercurrency.base.BaseViewModel
import com.btg.convertercurrency.data_local.RepositoryCurrencyLayerLocal
import com.btg.convertercurrency.features.base_entity.CurrencyItem
import com.btg.convertercurrency.features.util.Event
import com.btg.convertercurrency.features.util.default
import kotlinx.coroutines.launch

class ListCurrencyViewModel(
    application: Application,
    private val currencyLayerLocal: RepositoryCurrencyLayerLocal
) : BaseViewModel<Any>(application) {

    val listCurrencyRefresh = MutableLiveData<Event<List<CurrencyItem>>>().default(Event(listOf()))

    @OnLifecycleEvent(Lifecycle.Event.ON_CREATE)
    fun getListCurrency() {
        viewModelScope.launch {
            val list = currencyLayerLocal.listCurrenciesWithQuoties()
            listCurrencyRefresh.postValue(Event(list))
        }
    }
}