package com.btgpactual.teste.mobile_challenge.data.remote

import com.btgpactual.teste.mobile_challenge.data.remote.dto.CurrencyList
import com.btgpactual.teste.mobile_challenge.data.remote.dto.CurrencyValue
import retrofit2.http.GET
import retrofit2.http.Query

/**
 * Created by Carlos Souza on 16,October,2020
 */
interface SyncApi {

    @GET("list")
    suspend fun getListCurrencies(
        @Query("access_key") key: String = API_KEY
    ) : CurrencyList

    @GET("live")
    suspend fun getLiveCurrencies(
        @Query("access_key") key: String = API_KEY
    ) : CurrencyValue

    companion object {
        private const val API_KEY = "221db2e01d089e70ced51ce1d33015a9"
    }
}