package com.btgpactual.domain.repository

import com.btgpactual.domain.entity.Currency
import io.reactivex.Single

interface CurrenciesRepository {

    fun getCurrencies(forceUpdate : Boolean) : Single<List<Currency>>
    fun convert(amount: Double, from : Currency, to : Currency) : Single<Double>

}