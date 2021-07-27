package com.btg.conversormonetario.view.viewmodel

import android.app.Application
import android.os.Handler
import androidx.lifecycle.MutableLiveData
import com.btg.conversormonetario.business.database.DataManager
import com.btg.conversormonetario.data.model.InfoCurrencyModel
import com.btg.conversormonetario.data.model.ItemSpinnerDecoration
import com.btg.conversormonetario.view.activity.ConverterCurrencyActivity
import com.btg.conversormonetario.view.adapter.SpinnerAdapter
import com.btg.conversormonetario.view.fragment.BottomSheetOptionFragment

open class ChooseCurrencyViewModel(val dataManager: DataManager, application: Application) :
    BaseViewModel(dataManager, application) {
    private var cardTouchable = MutableLiveData<ItemSpinnerDecoration>()
    private var extras = MutableLiveData<String>()
    var itemListChoosed = MutableLiveData<InfoCurrencyModel.DTO>()
    var localCurrenciesSingleton = MutableLiveData<ArrayList<InfoCurrencyModel.DTO>>()
    var currenciesFiltered = MutableLiveData<ArrayList<InfoCurrencyModel.DTO>>()

    companion object {
        const val ORDER_BY_CODE = "Código da Moeda"
        const val ORDER_BY_NAME = "Nome da Moeda"
    }

    fun onViewModelInitiated() {
        prepareGetOriginalListCurrencies()
    }

    fun prepareGetOriginalListCurrencies() {
        val list = originalCurrenciesSingleton.value
        localCurrenciesSingleton.value = list
    }

    fun prepareSpinnerOrderList() {
        val listForAdapter = arrayListOf(ORDER_BY_CODE, ORDER_BY_NAME)

        val adapter = SpinnerAdapter(currentContext.value!!, listForAdapter)

        val bottomSheet = BottomSheetOptionFragment(adapter)
        bottomSheet.itemSelected = { orderOption ->
            Handler().postDelayed({
                if (bottomSheet.isVisible || bottomSheet.isResumed)
                    bottomSheet.dismiss()
            }, 120)

            cardTouchable.value = ItemSpinnerDecoration().cardLightBlue()

            filterCurrenciesByOption(orderOption)
        }
        bottomSheet.show(currentContext.value!!.supportFragmentManager, "BottomSheetGeneric")
    }

    private fun filterCurrenciesByOption(orderOption: String) {
        when (orderOption) {
            ORDER_BY_CODE -> {
                val list = localCurrenciesSingleton.value
                list?.sortBy { it.code ?: "" }
                currenciesFiltered.value = list
            }

            ORDER_BY_NAME -> {
                val list = localCurrenciesSingleton.value
                list?.sortBy { it.name ?: "" }
                currenciesFiltered.value = list
            }
        }
    }

    private fun prepareToBack() {
        when (extras.value) {
            CURRENCY_ORIGIN -> {
                dataManager.saveOriginCurrencyCode(itemListChoosed.value?.code ?: "")
                backTo(ConverterCurrencyActivity::class.java)
            }
            CURRENCY_TARGET -> {
                dataManager.saveTargetCurrencyCode(itemListChoosed.value?.code ?: "")
                backTo(ConverterCurrencyActivity::class.java)
            }
        }
    }

    fun updateCurrencyChoosedValue(it: InfoCurrencyModel.DTO) {
        itemListChoosed.value = it
        prepareToBack()
    }

    fun goToConverterCurrency() {
        backTo(ConverterCurrencyActivity::class.java)
    }

    fun chooseCurrencyTypeFromIntent(extrasParameter: String?) {
        extras.value = extrasParameter
    }

}