package com.btg.conversormonetario.data.model

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName
import java.math.BigDecimal

class ConvertCurrencyModel {
    data class Response(
        @Expose @SerializedName("success") var success: Boolean? = false,
        @Expose @SerializedName("terms") var terms: String? = "",
        @Expose @SerializedName("privacy") var privacy: String? = "",
        @Expose @SerializedName("query") var query: QueryModel? = null,
        @Expose @SerializedName("info") var info: InfoModel? = null,
        @Expose @SerializedName("result") var result: BigDecimal? = null
    )

    data class QueryModel(
        @Expose @SerializedName("from") var from: String? = "",
        @Expose @SerializedName("to") var to: String? = "",
        @Expose @SerializedName("amount") var amount: Long? = null
    )

    data class InfoModel(
        @Expose @SerializedName("timestamp") var timestamp: Long? = null,
        @Expose @SerializedName("quote") var quote: BigDecimal? = null
    )
}