package com.romildosf.currencyconverter.datasource.rest

import com.google.gson.annotations.SerializedName

class DefaultErrorResponse (
    @SerializedName("code") val code: Int,
    @SerializedName("info") val info: String
)