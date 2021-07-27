package com.lucasnav.desafiobtg.modules.currencyConverter.networking

import com.lucasnav.desafiobtg.core.network.BaseNetwork.Companion.BASE_URL
import com.lucasnav.desafiobtg.modules.currencyConverter.model.CurrencyResponse
import com.lucasnav.desafiobtg.modules.currencyConverter.model.QuoteResponse
import io.reactivex.Observable
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

const val ACCESS_KEY = "1a9c3416547f1afa95ffeebcf268c87f"

interface CurrencyApi {

    @GET("${BASE_URL}list?access_key=$ACCESS_KEY")
    fun getCurrenciesFromApi(): Observable<CurrencyResponse>

    @GET("${BASE_URL}live?access_key=$ACCESS_KEY")
    fun getQuotesFromApi(
        @Query("currencies") currencies: String = ""
    ): Observable<QuoteResponse>
}
