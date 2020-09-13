package br.com.rcp.currencyconverter.fragments.viewmodels.base

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import br.com.rcp.currencyconverter.Converter
import br.com.rcp.currencyconverter.R
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

abstract class BaseViewModel(application: Application) : AndroidViewModel(application) {
    val	toast       : MutableLiveData<String>   = MutableLiveData()
    val	progress    : MutableLiveData<Boolean>  = MutableLiveData(false)

    protected open fun setLoading() {
        CoroutineScope(Dispatchers.Main).launch {
            progress.value = true
        }
    }

    protected open fun setNotLoading() {
        CoroutineScope(Dispatchers.Main).launch {
            progress.value = false
        }
    }

    protected open fun onServiceError() {
        CoroutineScope(Dispatchers.Main).launch {
            toast.value = getApplication<Converter>().applicationContext.getString(R.string.conn_error)
        }
    }
}