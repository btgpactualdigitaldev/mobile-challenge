package com.a.coinmaster.repository

import com.a.coinmaster.api.CoinMasterApi
import com.a.coinmaster.extension.makeRequest
import com.a.coinmaster.model.response.CurrenciesListResponse
import com.a.coinmaster.model.response.CurrencyResponse
import io.reactivex.Single

class CoinMasterRepository(private val serviceApi: CoinMasterApi) {
    fun getCurrenciesList(): Single<CurrenciesListResponse> =
        makeRequest {
            serviceApi.getCurrenciesList()
        }

    fun getCurrency(coin: String): Single<CurrencyResponse> =
        makeRequest {
            serviceApi.getCurrency(coin)
        }
}