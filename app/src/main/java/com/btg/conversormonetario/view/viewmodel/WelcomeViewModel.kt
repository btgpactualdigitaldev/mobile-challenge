package com.btg.conversormonetario.view.viewmodel

import android.app.Application
import android.os.Handler
import android.view.View.GONE
import android.view.View.VISIBLE
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.btg.conversormonetario.App
import com.btg.conversormonetario.business.database.DataManager
import com.btg.conversormonetario.business.repository.WelcomeRepository
import com.btg.conversormonetario.data.model.InfoCurrencyModel
import com.btg.conversormonetario.view.activity.ConverterCurrencyActivity
import kotlinx.coroutines.launch

open class WelcomeViewModel(
    private val infoCurrency: WelcomeRepository, dataManager: DataManager, application: Application
) :
    BaseViewModel(dataManager, application) {

    data class WelcomeLayout(var isWelcomeLayoutVisible: Int = 0, var isInitialSettingsVisible: Int = 0)
    val shouldChangeLayout = MutableLiveData<WelcomeLayout>()

    fun onActivityCreated() {
        shouldChangeLayout.value = WelcomeLayout(VISIBLE, GONE)
        Handler().postDelayed({
            callServiceGetKeyNameCurrencies()
        }, 2000)
    }

    private fun callServiceGetKeyNameCurrencies() {
        shouldChangeLayout.value = WelcomeLayout(GONE, VISIBLE)
        showLoading()
        viewModelScope.launch(webServiceException) {
            infoCurrency.getInfoCurrencies({
                if (it.success == true) {
                    hideLoading()
                    saveInfoCurrencyDatabase(it)
                    navigateTo(ConverterCurrencyActivity::class.java)
                } else {
                    hideLoading()
                    navigateTo(ConverterCurrencyActivity::class.java)
                }
            }, {
                onErrorResponse(currentContext.value!!, it)
            })
        }
    }

    private fun saveInfoCurrencyDatabase(infoCurrency: InfoCurrencyModel.Response) {
        val currencies = ArrayList<InfoCurrencyModel.DTO>()

        infoCurrency.currencies?.forEach {
            val dto = InfoCurrencyModel.DTO(it.key, it.value)
            currencies.add(dto)
        }

        App.setInfoCurrency(
            InfoCurrencyModel.Storage(
                infoCurrency.success, infoCurrency.terms, infoCurrency.privacy, currencies
            )
        )
    }
}