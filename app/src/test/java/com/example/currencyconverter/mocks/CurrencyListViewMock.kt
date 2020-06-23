package com.example.currencyconverter.mocks

import com.example.currencyconverter.entity.Currency
import com.example.currencyconverter.presentation.currencies.CurrencyListView

class CurrencyListViewMock : CurrencyListView {

    //sensors
    var calledFinishWithResultingCurrency = false
    var calledSetOrderButtonText = false
    var calledSetRecyclerViewArray = false
    var currencyList = arrayListOf<Currency>()

    override fun finishWithResultingCurrency(currency: Currency) {
        calledFinishWithResultingCurrency = true
    }

    override fun setOrderButtonText(text: String) {
        calledSetOrderButtonText = true
    }

    override fun setRecyclerViewArray(array: ArrayList<Currency>) {
        calledSetRecyclerViewArray = true
        currencyList = array
    }
}