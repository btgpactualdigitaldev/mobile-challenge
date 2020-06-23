package com.example.currencyconverter.mocks

import com.example.currencyconverter.entity.Currency
import com.example.currencyconverter.infrastructure.database.Database

class DatabaseMock: Database {

    //Sensors
    var onCreateCalled = false
    var postCurrenciesCalled = false
    var onDestroyCalled = false

    override fun onCreate() {
        onCreateCalled = true
    }

    override fun getCurrencies(): List<Currency> {
        val brl = Currency("BRL", "Brazilian Reals", 5.3453)
        val usd = Currency("USD", "American Dollar", 1.00)

        return listOf(usd, brl)
    }

    override fun postCurrencies(currencies: List<Currency>) {
        postCurrenciesCalled = true
    }

    override fun onDestroy() {
        onDestroyCalled = true
    }
}