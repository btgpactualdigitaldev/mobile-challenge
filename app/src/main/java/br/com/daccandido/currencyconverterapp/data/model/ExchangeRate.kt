package br.com.daccandido.currencyconverterapp.data.model

import android.os.Parcelable
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Parcelize
data class ExchangeRate (
    @SerializedName("success")
    val success: Boolean,
    @SerializedName("terms")
    val terms: String,
    @SerializedName("privacy")
    val privacy:String,
    @SerializedName("currencies")
    val currencies: Map<String, String>

) : Parcelable