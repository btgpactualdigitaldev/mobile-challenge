package br.com.btgpactual.currencyconverter.data.retrofit

import br.com.btgpactual.currencyconverter.data.retrofit.response.CurrencyBodyResponse
import br.com.btgpactual.currencyconverter.data.retrofit.response.QuotationBodyResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyLayerServices {

    companion object {
        private const val KEY = "1c4d25ed2160ce8973d3f5ea6e3719ec"
    }

    @GET("live")
    fun getQuoteList(
        @Query("access_key") key: String = KEY
    ): Call<QuotationBodyResponse>

    @GET("list")
    fun getCurrencyList(
        @Query("access_key") key: String = KEY
    ): Call<CurrencyBodyResponse>

}
