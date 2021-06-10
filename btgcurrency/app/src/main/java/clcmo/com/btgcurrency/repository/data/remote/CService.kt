package clcmo.com.btgcurrency.repository.data.remote

import clcmo.com.btgcurrency.repository.data.remote.response.*
import retrofit2.Response
import retrofit2.http.GET

interface CService {
    @GET("list")
    suspend fun listCurrencies(): Response<CResponse>

    @GET("live")
    suspend fun listQuotes(): Response<QResponse>
}