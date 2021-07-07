package com.gft.data.api

import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValueList
import retrofit2.Response
import retrofit2.http.GET

interface CurrencyApi {
    @GET("list?access_key=502c1ba22d71723556c4142a6cd57156&format=1")
    suspend fun getLabels(): Response<CurrencyLabelList>

    @GET("live?access_key=502c1ba22d71723556c4142a6cd57156&format=1")
    suspend fun getValues(): Response<CurrencyValueList>
}