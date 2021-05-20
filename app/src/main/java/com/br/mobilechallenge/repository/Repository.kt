package com.br.mobilechallenge.repository

import com.br.mobilechallenge.model.ListResponse
import com.br.mobilechallenge.model.QuotesResponse
import com.br.mobilechallenge.network.API_KEY
import com.br.mobilechallenge.network.EndPoint
import com.br.mobilechallenge.network.RetrofitInit

class Repository {

    private var url = "http://api.currencylayer.com/"

    private var service = EndPoint::class

    private val getService = RetrofitInit(url).create(service)

    suspend fun getQuoteService(): QuotesResponse = getService
        .getQuotes(API_KEY)

    suspend fun getCurrencyList(): ListResponse = getService
        .getCurrencyList(API_KEY)
}