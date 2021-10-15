package com.todeschini.currencyconverter.utils

import com.todeschini.currencyconverter.model.CurrencyName
import com.todeschini.currencyconverter.model.QuoteObject

fun convertMapToArrayListOfCurrencyName(map: Map<String, String>?): ArrayList<CurrencyName> {
    val list = arrayListOf<CurrencyName>()

    map?.forEach {(key, value) ->
        list.add(CurrencyName(key, value))
    }

    return list
}

fun convertMapToQuoteObject(map: Map<String, Double>?): QuoteObject? {
    var quoteObject: QuoteObject? = null

    map?.forEach {(key, value) ->
        quoteObject = QuoteObject(key, value)
    }

    return quoteObject
}


