package com.example.currencyconverter.presentation.currencies

import com.example.currencyconverter.entity.Currency

interface CurrencyListView {
    fun setRecyclerViewArray(array: ArrayList<Currency>)
    fun setOrderButtonText(text: String)
    fun finishWithResultingCurrency(currency: Currency)
}