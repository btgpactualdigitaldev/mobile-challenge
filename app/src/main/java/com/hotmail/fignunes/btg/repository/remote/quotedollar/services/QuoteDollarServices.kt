package com.hotmail.fignunes.btg.repository.remote.quotedollar.services

import com.hotmail.fignunes.btg.repository.remote.quotedollar.responses.QuoteDollarResponses
import io.reactivex.Single
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query

interface QuoteDollarServices {

    @GET("live")
    fun getQuoteDollar(
        @Query("access_key") accessKey: String,
        @Query("currencies") currencies: String

    ) : Single<Response<QuoteDollarResponses>>
}