package com.btgpactual.currencyconverter.data.repository

import com.btgpactual.currencyconverter.data.framework.retrofit.NetworkConnectionInterceptor
import com.btgpactual.currencyconverter.data.model.CurrencyModel

interface CurrencyExternalRepository {

    suspend fun getCurrencyModelList(networkConnectionInterceptor: NetworkConnectionInterceptor,callback: (result: CurrencyModelListResult) -> Unit)

    sealed class CurrencyModelListResult {
        class RequestSuccess(val listCurrencyModel: List<CurrencyModel>) : CurrencyModelListResult()
        class RequestError(val statusCode: Int) : CurrencyModelListResult()
        object UnhandledError : CurrencyModelListResult()
    }

}