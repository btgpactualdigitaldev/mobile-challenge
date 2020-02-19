package com.btgpactual.data.remote.api

import com.btgpactual.data.remote.model.ListResponse
import com.btgpactual.data.remote.model.LiveResponse
import io.reactivex.Single
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrencyLayerApi {

    @GET("/list")
    fun getList(@Query("access_key") key : String) : Single<ListResponse>

    @GET("/live")
    fun getLive(@Query("access_key") key : String) : Single<LiveResponse>


}