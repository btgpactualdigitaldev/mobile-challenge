package com.btg.teste.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

data class ConversionViewModel(
    val conversionLiveData: MutableLiveData<MutableList<Conversion>> = MutableLiveData(ArrayList()),
    val list: MutableList<Conversion> = ArrayList(),
    var listfilter: MutableList<Conversion> = ArrayList()
) : ViewModel()