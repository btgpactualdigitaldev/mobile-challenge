package com.btgpactual.data.remote.source

import com.btgpactual.domain.entity.Currency
import io.reactivex.Single

interface ListRemoteDataSource{
    fun getCurrencies(apiKey : String) : Single<List<Currency>>

}