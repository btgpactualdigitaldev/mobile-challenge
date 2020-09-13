package br.com.rcp.currencyconverter.fragments.viewmodels

import android.app.Application
import android.view.View
import androidx.lifecycle.MutableLiveData
import br.com.rcp.currencyconverter.database.entities.Currency
import br.com.rcp.currencyconverter.fragments.viewmodels.base.BaseViewModel

class ConverterViewModel(application: Application) : BaseViewModel(application) {
    val click   = MutableLiveData(0)
    val error   = MutableLiveData(false)
    val value   = MutableLiveData("")
    val result  = MutableLiveData("")

    fun sourceCurrencyButton(view: View) {
        click.value = view.id
    }

    fun convert(source: Currency?, target: Currency?) {
        if (source == null || target == null || value.value?.isEmpty() == true) {
            error.value = true
        } else {
            result.value = (((value.value?.toDouble() ?: 0.0) / source.value) * target.value).toString()
        }
    }
}