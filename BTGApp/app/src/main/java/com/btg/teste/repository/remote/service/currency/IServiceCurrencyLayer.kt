package com.btg.teste.repository.remote.service.currency

import com.btg.teste.entity.Currencies
import com.btg.teste.entity.CurrencyLayer
import retrofit2.Response

interface IServiceCurrencyLayer {

    fun currencyLayer(
        success: (currencyLayer: Response<CurrencyLayer?>) -> Unit,
        failure: (throwable: Throwable) -> Unit
    )

    fun currencies(
        success: (currencies: Response<Currencies?>) -> Unit,
        failure: (throwable: Throwable) -> Unit
    )
}