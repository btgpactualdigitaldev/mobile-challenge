package br.com.leonamalmeida.mobilechallenge.data.source.remote

import br.com.leonamalmeida.mobilechallenge.util.PARAM_ACCESS_KEY
import io.reactivex.Single
import okhttp3.ResponseBody
import retrofit2.http.GET
import retrofit2.http.Query

/**
 * Created by Leo Almeida on 27/06/20.
 */
interface CurrencyLayerApi {

    @GET("list")
    fun getAvailableCurrencies(@Query(PARAM_ACCESS_KEY) key: String = "f2a8df2485baf25a846f4c18e4f65538"): Single<ResponseBody>

    @GET("live")
    fun getRealTimeRate(@Query(PARAM_ACCESS_KEY) key: String = "f2a8df2485baf25a846f4c18e4f65538"): Single<ResponseBody>
}