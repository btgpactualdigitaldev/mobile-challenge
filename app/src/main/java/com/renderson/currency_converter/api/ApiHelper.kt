package com.renderson.currency_converter.api

import com.renderson.currency_converter.models.CurrencyResponse
import com.renderson.currency_converter.models.QuotesResponse
import retrofit2.Response

interface ApiHelper {
    suspend fun getAllCurrencies(): Response<CurrencyResponse>

    suspend fun getQuotes(): Response<QuotesResponse>
}