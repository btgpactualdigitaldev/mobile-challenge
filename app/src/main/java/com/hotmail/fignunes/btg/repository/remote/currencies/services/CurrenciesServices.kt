package com.hotmail.fignunes.btg.repository.remote.currencies.services

import com.hotmail.fignunes.btg.repository.remote.currencies.responses.CurrenciesListResponses
import io.reactivex.Single
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query

interface CurrenciesServices {

    @GET("list")
    fun getCurrenciesList(
        @Query("access_key") accessKey: String

    ) : Single<Response<CurrenciesListResponses>>
}