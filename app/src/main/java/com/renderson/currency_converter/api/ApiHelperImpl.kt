package com.renderson.currency_converter.api

import com.renderson.currency_converter.models.CurrencyResponse
import com.renderson.currency_converter.models.QuotesResponse
import retrofit2.Response
import javax.inject.Inject

class ApiHelperImpl @Inject constructor(
    private val apiService: ApiService
): ApiHelper{
    override suspend fun getAllCurrencies():
            Response<CurrencyResponse> = apiService.getAllCurrencies()

    override suspend fun getQuotes():
            Response<QuotesResponse> = apiService.getAllQuotes()
}