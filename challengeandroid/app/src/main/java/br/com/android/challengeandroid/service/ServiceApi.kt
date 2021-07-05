package br.com.android.challengeandroid.service


import br.com.android.challengeandroid.model.ResultCoinList
import br.com.android.challengeandroid.model.ResultCoinPrice
import retrofit2.http.GET
import retrofit2.http.Query

const val APIKEY = "fb0af511fc35518f2274bcc8adc94d31"

interface ServiceApi {

    @GET("list")
    suspend fun getCoins(
        @Query("access_key") apiKey: String = APIKEY,
        @Query("currencies") currencies: String,
        @Query("source") source: String
    ): ResultCoinList


    @GET("live")
    suspend fun getPrice(
        @Query("access_key") apiKey: String = APIKEY,
        @Query("currencies") currencies: String,
        @Query("source") source: String
    ): ResultCoinPrice
}
