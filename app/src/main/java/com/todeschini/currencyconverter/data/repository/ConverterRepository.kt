package com.todeschini.currencyconverter.data.repository

import com.todeschini.currencyconverter.data.network.RetrofitConfigurator

class ConverterRepository {

    suspend fun getLiveCurrency(currency: String) =
        RetrofitConfigurator.endpointService.getLiveCurrency(currency)
}