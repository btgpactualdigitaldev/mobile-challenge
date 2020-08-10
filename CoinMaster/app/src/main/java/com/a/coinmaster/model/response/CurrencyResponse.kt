package com.a.coinmaster.model.response

import android.os.Parcelable
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Parcelize
data class CurrencyResponse(
    @SerializedName("privacy")
    val privacy: String? = null,
    @SerializedName("quotes")
    val quotes: HashMap<String, String> = hashMapOf(),
    @SerializedName("source")
    val source: String? = null,
    @SerializedName("success")
    val success: Boolean? = null,
    @SerializedName("terms")
    val terms: String? = null,
    @SerializedName("timestamp")
    val timestamp: Int? = null
) : Parcelable