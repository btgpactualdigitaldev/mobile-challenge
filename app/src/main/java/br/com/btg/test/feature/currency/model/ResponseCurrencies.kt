package br.com.btg.test.feature.currency.model

import android.os.Parcelable
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize


@Parcelize
data class ResponseCurrencies(
    @SerializedName("success") val success: Boolean?,
    @SerializedName("currencies") val currencies: Map<String, String>?
) : Parcelable