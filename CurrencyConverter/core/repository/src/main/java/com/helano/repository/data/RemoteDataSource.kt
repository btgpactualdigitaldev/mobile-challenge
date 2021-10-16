package com.helano.repository.data

import com.helano.network.responses.CurrenciesResponse
import com.helano.network.responses.QuotesResponse
import com.helano.network.services.CurrencyLayerService
import com.helano.shared.Constants.API_KEY
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class RemoteDataSource @Inject constructor(private val service: CurrencyLayerService) {

    suspend fun currencies(): CurrenciesResponse {
        return service.list(API_KEY)
    }

    suspend fun quotes(): QuotesResponse {
        return service.live(API_KEY)
    }
}