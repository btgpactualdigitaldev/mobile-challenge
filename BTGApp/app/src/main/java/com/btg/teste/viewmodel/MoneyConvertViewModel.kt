package com.btg.teste.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

data class MoneyConvertViewModel(
    val moneyConvert: MoneyConvert = MoneyConvert(),
    val moneyConvertLiveData: MutableLiveData<MoneyConvert> = MutableLiveData(moneyConvert)
    ) : ViewModel()