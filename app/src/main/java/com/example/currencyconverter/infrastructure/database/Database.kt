package com.example.currencyconverter.infrastructure.database

import com.example.currencyconverter.entity.Currency

interface Database {

    fun onCreate()
    fun getCurrencies(): List<Currency>
    fun postCurrencies(currencies: List<Currency>)
    fun onDestroy()

}