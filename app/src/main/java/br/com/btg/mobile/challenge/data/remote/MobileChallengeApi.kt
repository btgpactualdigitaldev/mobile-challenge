package br.com.btg.mobile.challenge.data.remote

import br.com.btg.mobile.challenge.data.model.Price
import br.com.btg.mobile.challenge.data.model.Rate
import br.com.btg.mobile.challenge.data.model.Response
import retrofit2.http.GET

interface MobileChallengeApi {

    @GET("/list")
    suspend fun getRates(): Response<List<Rate>?>

    @GET("/live")
    suspend fun getPrices(): Response<List<Price>?>
}
