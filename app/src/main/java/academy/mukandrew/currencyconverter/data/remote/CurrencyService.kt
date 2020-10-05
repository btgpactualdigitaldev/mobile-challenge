package academy.mukandrew.currencyconverter.data.remote

import academy.mukandrew.currencyconverter.data.remote.responses.CurrencyResponse
import academy.mukandrew.currencyconverter.data.remote.responses.QuoteResponse
import retrofit2.Response
import retrofit2.http.GET

interface CurrencyService {
    @GET("list")
    suspend fun listCurrencies(): Response<CurrencyResponse>

    @GET("live")
    suspend fun listQuotes(): Response<QuoteResponse>
}