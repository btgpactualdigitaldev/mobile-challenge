package com.romildosf.currencyconverter.view

import android.app.Activity
import android.content.Context
import android.view.View
import android.view.inputmethod.InputMethodManager
import android.widget.SearchView
import com.romildosf.currencyconverter.dao.Currency
import com.romildosf.currencyconverter.util.Filters

class CurrencyInputFilter(private val context: Context, private val searchView: SearchView, private val currencies: List<Currency>) {
    val foundItems = mutableListOf<Currency>()
    var changesListener: (currencies: List<Currency>) -> Unit = {}

    init {
        init()
    }

    private fun init() {

        val searchItems = mutableMapOf<Int, String>()
        currencies.forEachIndexed { idx, it ->
            searchItems[idx] = "${it.symbol} ${it.fullName}"
        }

        searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                hideKeyboardFrom(context, searchView)
                return true
            }

            override fun onQueryTextChange(newText: String?): Boolean {
                onNewEntry(newText, searchItems)
                return true
            }
        })
    }

    private fun onNewEntry(
        newText: String?,
        searchItems: MutableMap<Int, String>
    ) {
        foundItems.clear()

        if (!newText.isNullOrBlank()) {
            val filteredIdx = Filters.filter(newText, searchItems)
            filteredIdx.forEach {
                foundItems.add(currencies[it])
            }
            changesListener.invoke(foundItems)
        } else {
            foundItems.addAll(currencies)
        }

        changesListener.invoke(foundItems)
    }

    fun hideKeyboardFrom(context: Context, view: View) {
        val imm: InputMethodManager = context.getSystemService(Activity.INPUT_METHOD_SERVICE) as InputMethodManager
        imm.hideSoftInputFromWindow(view.windowToken, 0)
    }
}