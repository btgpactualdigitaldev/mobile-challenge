package com.todeschini.currencyconverter.data.repository

import com.todeschini.currencyconverter.data.network.IEndpoint
import com.todeschini.currencyconverter.data.network.RetrofitConfigurator

class CurrenciesListRepository {

    suspend fun getAllCurrencies() =
        RetrofitConfigurator.endpointService.getAllCurrencies()
}