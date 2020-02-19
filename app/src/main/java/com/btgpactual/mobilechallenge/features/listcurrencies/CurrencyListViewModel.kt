package com.btgpactual.mobilechallenge.features.listcurrencies

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.btgpactual.domain.entity.Currency
import com.btgpactual.domain.usecases.GetCurrencyUseCase
import com.btgpactual.mobilechallenge.viewmodel.BaseViewModel
import com.btgpactual.mobilechallenge.viewmodel.StateMachineSingle
import com.btgpactual.mobilechallenge.viewmodel.ViewState
import io.reactivex.Scheduler
import io.reactivex.rxkotlin.plusAssign

class CurrencyListViewModel(
    private val listUseCase: GetCurrencyUseCase,
    private val uiScheduler: Scheduler
) : BaseViewModel() {

    private val originalList = mutableListOf<Currency>()

    private val _currencyData = MutableLiveData<ViewState<List<Currency>>>().also{
        disposables += listUseCase.execute(force =  false).observeOn(uiScheduler)
            .compose(StateMachineSingle())
            .subscribe({state ->
                when(state){
                    is ViewState.Success -> {
                        originalList.clear()
                        originalList.addAll(state.data)
                    }
                }

                it.postValue(state)
            },{
                //Not Necessary because ViewState handle it
            })
    }

    val currencyData : LiveData<ViewState<List<Currency>>> = _currencyData


    fun search(query: String) {
          val filteredList = originalList.filter {it.code.startsWith(query, true) || it.name.startsWith(query,true)}
          _currencyData.postValue(ViewState.Success(filteredList))
    }

    fun clearSearch() {
        _currencyData.postValue(ViewState.Success<List<Currency>>(originalList))
    }
}