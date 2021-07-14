package com.sugarspoon.data.remote.datasources

import com.sugarspoon.data.remote.services.ExchangeRateService
import com.sugarspoon.data.remote.services.ServiceGenerator
import com.sugarspoon.desafiobtg.BuildConfig.URL_BASE

object ExchangeRateDataSource {
    private var service = ServiceGenerator.createService(
        serviceClass = ExchangeRateService::class.java,
        url = URL_BASE
    )

    fun fetchSupportedCurrencies() =
        service.getSupportedCurrencies()

    fun fetchRealTimeRates() =
        service.getRealTimeRates()

    fun convertCurrency(
        from: String,
        to: String,
        amount: Float
    ) = service.convertCurrency(
        from = from,
        to = to,
        amount = amount
    )
}