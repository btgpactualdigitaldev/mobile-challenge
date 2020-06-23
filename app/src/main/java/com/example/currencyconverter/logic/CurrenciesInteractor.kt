package com.example.currencyconverter.logic

import com.example.currencyconverter.entity.Currency
import com.example.currencyconverter.infrastructure.database.Database
import com.example.currencyconverter.presentation.currencies.CurrencyListView

class CurrenciesInteractor(val view : CurrencyListView,
                           val database: Database) {

    val ORDER_TICKER = "ORDERED BY TICKER"
    val ORDER_NAME = "ORDERED BY NAME"

    private var currentOrder = ORDER_TICKER
    private var currentQuery = ""

    fun onCreate() {
        database.onCreate()
        clearSearch()
    }

    fun search(query: String) {
        currentQuery = query
        if(currentOrder == ORDER_TICKER) {
            orderByTicker()
        } else {
            orderByName()
        }
    }

    fun clearSearch() {
        currentQuery = ""
        view.setRecyclerViewArray(ArrayList(database.getCurrencies()))
    }

    fun orderByTicker() {
        currentOrder = ORDER_TICKER
        view.setRecyclerViewArray(ArrayList(database.getCurrencies().sortedBy { it.symbol }.filter { it.matchesQuery(currentQuery) }))
        view.setOrderButtonText(ORDER_TICKER)
    }

    fun orderByName() {
        currentOrder = ORDER_NAME
        view.setRecyclerViewArray(ArrayList(database.getCurrencies().sortedBy { it.name }.filter { it.matchesQuery(currentQuery) }))
        view.setOrderButtonText(ORDER_NAME)
    }

    fun reorderList() {
         if (currentOrder == ORDER_TICKER) orderByName() else orderByTicker()
    }


    fun onCurrencySelected(selectedCurrency: Currency) {
        view.finishWithResultingCurrency(selectedCurrency)
    }

    fun onDestroy() {
        database.onDestroy()
    }
}