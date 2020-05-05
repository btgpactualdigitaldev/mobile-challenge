package com.btg.conversormonetario.data.model

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName
import retrofit2.http.FieldMap

class InfoCurrencyModel {
    data class Response(
        @Expose @SerializedName("success") var success: Boolean? = false,
        @Expose @SerializedName("terms") var terms: String? = "",
        @Expose @SerializedName("privacy") var privacy: String? = "",
        @Expose @SerializedName("currencies") @FieldMap var currencies: Map<String, String>? = null
    )

    data class Storage(
        var success: Boolean? = false,
        var terms: String? = "",
        var privacy: String? = "",
        var currencies: ArrayList<DTO>? = arrayListOf()
    )

    data class DTO(
        var code: String? = "",
        var name: String? = ""
    )
}