package br.com.convertify.api.calls

import br.com.convertify.api.responses.CurrencyApiResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyApiInterface {
    @GET("/list")
    fun getAvailableCurrencies(@Query("access_key") apiKey: String): Call<CurrencyApiResponse>
}