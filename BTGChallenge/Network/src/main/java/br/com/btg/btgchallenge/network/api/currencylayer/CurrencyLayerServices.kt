package br.com.btg.btgchallenge.network.api.currencylayer;

import br.com.btg.btgchallenge.network.model.ApiResponse
import okhttp3.MultipartBody
import okhttp3.RequestBody
import retrofit2.http.*

interface CurrencyLayerServices {
    @GET("/list")
    suspend fun getCurrencies(): ApiResponse<Any>

    @GET("/live")
    suspend fun getRealTimeRates(): ApiResponse<Any>
}