package com.btg.converter.data.remote.entity

import com.google.gson.annotations.SerializedName
import java.io.Serializable
import java.util.*

data class ApiErrors(
    @SerializedName("message")
    val errorMessage: String?,
    @SerializedName("errors")
    val errors: ArrayList<String>?
) : Serializable