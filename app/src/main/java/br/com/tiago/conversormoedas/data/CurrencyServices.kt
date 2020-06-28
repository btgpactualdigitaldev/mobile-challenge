package br.com.tiago.conversormoedas.data

import br.com.tiago.conversormoedas.data.response.CoinsBodyResponse
import br.com.tiago.conversormoedas.data.response.ConversorBodyResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyServices {

    @GET("list")
    fun getCoins(
        @Query("access_key") apiKey: String = "a9da032bd33f95c8a1612e3019471491"
    ): Call<CoinsBodyResponse>

    @GET("live")
    fun getRates(
        @Query("access_key") apiKey: String = "a9da032bd33f95c8a1612e3019471491",
        @Query("currencies") currencies: String
    ): Call<ConversorBodyResponse>
}