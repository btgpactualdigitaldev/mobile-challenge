package com.svm.btgmoneyconverter.viewmodel

import android.content.Context
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.svm.btgmoneyconverter.utils.DBAccess

open class BaseVM: ViewModel() {

    var loading: MutableLiveData<Boolean> = MutableLiveData()
    lateinit var context: Context
    val cDb = DBAccess.currenciesAccess
    val qDb = DBAccess.quotesAccess

    fun initContext(context: Context){
        this.context = context

    }

}