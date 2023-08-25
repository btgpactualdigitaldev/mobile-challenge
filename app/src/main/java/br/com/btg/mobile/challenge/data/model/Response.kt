package br.com.btg.mobile.challenge.data.model

import com.squareup.moshi.Json

data class Response<T>(
    @Json(name = "code") val code: Int,
    @Json(name = "message") val message: String,
    @Json(name = "data") val data: T
)
