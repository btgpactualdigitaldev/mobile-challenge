package com.svm.btgmoneyconverter.data.webservice

import com.svm.btgmoneyconverter.data.webservice.result.CurrencyResult
import com.svm.btgmoneyconverter.data.webservice.result.QuoteResult
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Headers

interface API {

    @Headers("Content-Type: application/json", "Accept: application/json")
    @GET(currencyUrl)
    fun getCurrency(): Call<CurrencyResult>

    @Headers("Content-Type: application/json", "Accept: application/json")
    @GET(liveUrl)
    fun getLive(): Call<QuoteResult>

}