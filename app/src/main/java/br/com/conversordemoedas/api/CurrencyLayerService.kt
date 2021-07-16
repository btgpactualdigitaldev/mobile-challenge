package br.com.conversordemoedas.api

import br.com.conversordemoedas.model.List
import br.com.conversordemoedas.model.Live
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyLayerService {

    companion object {
        const val apiAcessKey = "57f6dc777bbc4f0574d6d4a0b1d9c2ef"
    }

    @GET("list?access_key=$apiAcessKey")
    fun getCurrencyList(): Call<List>

    @GET("live?access_key=$apiAcessKey&format=1")
    fun getCurrencyLive(@Query("currencies") currencies: String): Call<Live>



}