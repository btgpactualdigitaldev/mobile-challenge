package com.sugarspoon.data.repositories

import com.sugarspoon.data.remote.datasources.ExchangeRateDataSource

object ExchangeRateRepository {

    fun fetchSupportedCurrencies() =
        ExchangeRateDataSource.fetchSupportedCurrencies()

    fun fetchRealTimeRates() =
        ExchangeRateDataSource.fetchRealTimeRates()
}