package com.sugarspoon.data.local.model

import com.sugarspoon.data.remote.model.CurrenciesResponse

data class CurrencyModel (
    val code: String,
    val name: String
)

fun CurrenciesResponse.toListCurrencyModel(): List<CurrencyModel>{
    val currencyModel = mutableListOf<CurrencyModel>()
    this.currencies.entries.forEach {
        currencyModel.add(
            CurrencyModel(code = it.key, name = it.value)
        )
    }
    return currencyModel
}