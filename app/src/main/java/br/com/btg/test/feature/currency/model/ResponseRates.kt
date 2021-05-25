package br.com.btg.test.feature.currency.model

import android.os.Parcelable
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize


@Parcelize
data class ResponseRates(
    @SerializedName("source") val success: Boolean?,
    @SerializedName("quotes") val quotes: Map<String, Double>?
) : Parcelable