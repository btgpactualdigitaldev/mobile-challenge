package com.btgpactual.currencyconverter.data.framework.retrofit

import com.btgpactual.currencyconverter.data.model.CurrencyModel

sealed class CurrencyListResult {
    class Success(val currencyList: List<CurrencyModel>) : CurrencyListResult()
    class ApiError(val statusCode: Int) : CurrencyListResult()
    object ServerError : CurrencyListResult()
}