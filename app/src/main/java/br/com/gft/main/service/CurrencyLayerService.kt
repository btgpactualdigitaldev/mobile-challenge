package br.com.gft.main.service

import br.com.gft.main.service.model.CurrencyListResponse
import br.com.gft.main.service.model.ConvertResponse
import br.com.gft.main.service.model.CurrentQuotationFromDollarResponse
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyLayerService {
    @GET("/list")
    suspend fun listCurrencies(): Response<CurrencyListResponse>

    @GET("/live")
    suspend fun getCurrentQuotationFromDollar(@Query("currencies") currencyTo:String): Response<CurrentQuotationFromDollarResponse>

    @GET("/live")
    suspend fun currentUSD(): Any
}
