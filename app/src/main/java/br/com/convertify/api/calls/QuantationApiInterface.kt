package br.com.convertify.api.calls

import br.com.convertify.api.responses.CurrencyApiResponse
import br.com.convertify.api.responses.QuotationApiResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface QuantationApiInterface {
    @GET("/live")
    fun getAvailableQuotation(@Query("access_key") apiKey: String): Call<QuotationApiResponse>
}