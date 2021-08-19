package br.dev.infra.btgconversiontool.network

import br.dev.infra.btgconversiontool.data.CurrencyList
import br.dev.infra.btgconversiontool.data.CurrencyQuotes
import retrofit2.http.GET

interface CurrencyApiInterface {

    @GET("list")
    suspend fun getListApi(): CurrencyList

    @GET("live")
    suspend fun getQuotesApi(): CurrencyQuotes
}
