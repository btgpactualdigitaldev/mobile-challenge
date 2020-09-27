package com.example.btgconvert.presentation.currencyList


import android.content.Context
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.btgconvert.data.db.DataBaseHandler
import com.example.btgconvert.data.model.Currency

class CurrencyListViewModel : ViewModel() {
    val currencyListLiveData : MutableLiveData<List<Currency>> = MutableLiveData()

    fun getCurrencyDb(context: Context,text: String = ""){
        val db = DataBaseHandler(context)
        if(text.isEmpty()) {
            currencyListLiveData.value = db.getData()
        }else{
            currencyListLiveData.value = db.getDataOnFilter(text)
        }
    }


}