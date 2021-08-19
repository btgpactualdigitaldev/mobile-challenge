package com.example.challengesavio.api.repositories

import com.example.challengesavio.MyApplication
import com.example.challengesavio.api.services.RetrofitService
import com.example.challengesavio.data.entity.Currency
import com.example.challengesavio.data.entity.Quote

class MainRepository constructor(private val retrofitService: RetrofitService) {

    fun getAllCurrencies() = retrofitService.searchCurrencies()
    fun getAllQuotes() = retrofitService.searchQuotes()

    fun getCurrenciesLocal() = MyApplication.database?.currencyDao()?.getAllCurrencies() as ArrayList<Currency>

    fun getQuotesLocal() = MyApplication.database?.currencyQuoteDao()?.getAllQuotes() as ArrayList<Quote>
}