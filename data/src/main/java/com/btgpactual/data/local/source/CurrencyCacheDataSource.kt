package com.btgpactual.data.local.source

import com.btgpactual.domain.entity.Currency
import io.reactivex.Single

interface CurrencyCacheDataSource{

    fun getCurrencies() : Single<List<Currency>>

    fun insertData(currencies : List<Currency>)

    fun updateData(currencies: List<Currency>)

}