package br.com.btg.test.feature.currency.api

import br.com.btg.test.feature.currency.model.ResponseCurrencies
import br.com.btg.test.feature.currency.model.ResponseRates
import retrofit2.http.GET
import retrofit2.http.Query

interface ConvertAPI {

    @GET("/live")
    suspend fun liveRates(
        @Query("currencies") currencies: String
    ): ResponseRates

    @GET("/list")
    suspend fun currenciesList(
    ): ResponseCurrencies
}