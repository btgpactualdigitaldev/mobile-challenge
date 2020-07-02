package com.test.btg.repository

import com.test.core.model.Lives
import io.reactivex.Observable
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyApi {
    @GET("/live")
    fun requestLive(@Query("access_key") accessKey: String = "536217e91d225189a7fd29116e662d2a"): Observable<Response<Lives>>
}


