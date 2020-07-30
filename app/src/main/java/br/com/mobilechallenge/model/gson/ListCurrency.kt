package br.com.mobilechallenge.model.gson

import android.os.Parcelable

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

import kotlinx.android.parcel.Parcelize

@Parcelize
data class ListCurrency(@SerializedName("success")    @Expose var success: Boolean,
                        @SerializedName("terms")      @Expose var terms: String,
                        @SerializedName("privacy")    @Expose var privacy: String,
                        @SerializedName("currencies") @Expose var currencies: Currencies
) : Parcelable