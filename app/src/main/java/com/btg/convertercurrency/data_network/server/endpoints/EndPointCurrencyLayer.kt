package com.btg.convertercurrency.data_network.server.endpoints


import com.btg.convertercurrency.data_network.server.endpoints.response.CurrencyObjectResponse
import com.btg.convertercurrency.data_network.server.endpoints.response.QuotesObjectResponse
import retrofit2.http.GET


interface EndPointCurrencyLayer {

    @GET("list")
    suspend fun listCurrencie(): CurrencyObjectResponse

    @GET("live")
    suspend fun listQuotes(): QuotesObjectResponse

}