package com.romildosf.currencyconverter.datasource.rest

import retrofit2.http.GET

interface CurrencyService {
    @GET("list?access_key=53c9071bdfb67e8aa0ecbf38e4c4c3bd")
    suspend fun fetchList(): CurrencyListResponse

    @GET("live?access_key=53c9071bdfb67e8aa0ecbf38e4c4c3bd")
    suspend fun fetchCurrencyQuotes(): QuotesListResponse
}