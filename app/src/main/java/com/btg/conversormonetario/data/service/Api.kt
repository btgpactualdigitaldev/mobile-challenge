package com.btg.conversormonetario.data.service

import com.btg.conversormonetario.data.model.ConvertCurrencyModel
import com.btg.conversormonetario.data.model.InfoCurrencyModel
import kotlinx.coroutines.Deferred
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query

interface Api {
    companion object {
        const val ACCESS_KEY = "2b3016266ea3bb43a5ff14546026daea"
        const val PARAMETER_CONVERT_CURRENCY = "convert?access_key=$ACCESS_KEY"
        const val PARAMETER_INFO_CURRENCIES = "list?access_key=$ACCESS_KEY"
    }

    @GET(PARAMETER_CONVERT_CURRENCY)
    fun getCurrencyConverted(
        @Query("from") currentCurrency: String,
        @Query("to") targetCurrency: String,
        @Query("amount") amountCurrency: String
    ): Deferred<Response<ConvertCurrencyModel.Response>>

    @GET(PARAMETER_INFO_CURRENCIES)
    fun getInfoCurrencies(): Deferred<Response<InfoCurrencyModel.Response>>

}