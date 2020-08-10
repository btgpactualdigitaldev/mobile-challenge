package com.a.coinmaster.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.a.coinmaster.model.StateError
import com.a.coinmaster.model.StateLoading
import com.a.coinmaster.model.StateResponse
import com.a.coinmaster.model.StateSuccess
import com.a.coinmaster.model.vo.CurrenciesListVO
import com.a.coinmaster.usecase.GetCurrenciesListUseCase

class CoinListViewModel(
    private val currenciesListUseCase: GetCurrenciesListUseCase
) : BaseViewModel() {

    val currenciesListLiveData: LiveData<StateResponse<CurrenciesListVO>>
        get() = _currenciesListLiveData

    private val _currenciesListLiveData = MutableLiveData<StateResponse<CurrenciesListVO>>()

    var coinSelected: Pair<String, String>? = null

    fun fetchCurrenciesList() {
        currenciesListUseCase
            .execute(Unit)
            .doOnSubscribe { _currenciesListLiveData.postValue(StateLoading()) }
            .subscribe(
                {
                    _currenciesListLiveData.postValue(StateSuccess(it))
                },
                {
                    _currenciesListLiveData.postValue(StateError(it))
                }
            )
            .also { disposables.addAll(it) }
    }
}