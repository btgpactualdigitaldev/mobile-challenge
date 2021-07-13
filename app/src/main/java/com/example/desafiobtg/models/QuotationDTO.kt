package com.example.desafiobtg.models

import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName

data class QuotationDTO(
        @SerializedName("success") val success: Boolean?,
        @SerializedName("source") val source: String?,
        @SerializedName("quotes") val quotes: HashMap<String, Double>?
) : Parcelable {
    constructor(parcel: Parcel) : this(
        parcel.readValue(Boolean::class.java.classLoader) as? Boolean,
        parcel.readString(),
        TODO("currencies")
    ) {
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeValue(success)
        parcel.writeString(source)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<QuotationDTO> {
        override fun createFromParcel(parcel: Parcel): QuotationDTO {
            return QuotationDTO(parcel)
        }

        override fun newArray(size: Int): Array<QuotationDTO?> {
            return arrayOfNulls(size)
        }
    }

}