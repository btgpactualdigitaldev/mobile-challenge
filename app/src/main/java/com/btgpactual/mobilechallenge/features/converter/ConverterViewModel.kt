package com.btgpactual.mobilechallenge.features.converter

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.btgpactual.domain.entity.Currency
import com.btgpactual.domain.usecases.ConvertUseCase
import com.btgpactual.mobilechallenge.viewmodel.BaseViewModel
import com.btgpactual.mobilechallenge.viewmodel.StateMachineSingle
import com.btgpactual.mobilechallenge.viewmodel.ViewState
import io.reactivex.Scheduler
import io.reactivex.rxkotlin.plusAssign

class ConverterViewModel(
    private val converterUseCase: ConvertUseCase,
    private val uiScheduler: Scheduler
) : BaseViewModel() {

    private val _conversionData =  MutableLiveData<ViewState<Double>>()
    private val _currencyFromData = MutableLiveData<Currency>()
    private val _currencyToData = MutableLiveData<Currency>()

    val conversionData : LiveData<ViewState<Double>> = _conversionData
    val currencyFromData : LiveData<Currency> = _currencyFromData
    val currencyToData : LiveData<Currency> = _currencyToData



    fun converter(amount: Double){
        val currencyFrom = currencyFromData.value
        val currencyTo = currencyToData.value

        if (currencyFrom!=null && currencyTo != null){
            disposables += converterUseCase.execute(amount,currencyFrom,currencyTo).observeOn(uiScheduler)
                .compose(StateMachineSingle())
                .subscribe({
                    _conversionData.postValue(it)
                },{
                    //Not Necessary because ViewState handle it
                })
        }



    }

    fun setCurrentFrom(currency: Currency){
        _currencyFromData.postValue(currency)
    }

    fun setCurrentTo(currency: Currency){
        _currencyToData.postValue(currency)
    }

}