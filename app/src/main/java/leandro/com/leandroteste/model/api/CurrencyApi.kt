package leandro.com.leandroteste.model.api

import leandro.com.leandroteste.model.response.ConvertResponse
import leandro.com.leandroteste.model.response.CurrencyListResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyApi {
    companion object {
        private const val ACCESS_KEY: String = "?access_key=3eab59c5260ed0ea7df8955fbc3306ba"
    }

    @GET("list$ACCESS_KEY")
    fun listCurrencies(): Call<CurrencyListResponse>

    @GET("live$ACCESS_KEY&currencies=")
    fun convert(@Query("currencies") currencies: String): Call<ConvertResponse>
}