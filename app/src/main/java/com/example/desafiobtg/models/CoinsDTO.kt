package com.example.desafiobtg.models

import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName

data class CoinsDTO(
        @SerializedName("success") val success: Boolean?,
        @SerializedName("currencies") val currencies: HashMap<String, String>?
) : Parcelable {
    constructor(parcel: Parcel) : this(
            parcel.readValue(Boolean::class.java.classLoader) as? Boolean,
            TODO("currencies"))

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeValue(success)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<CoinsDTO> {
        override fun createFromParcel(parcel: Parcel): CoinsDTO {
            return CoinsDTO(parcel)
        }

        override fun newArray(size: Int): Array<CoinsDTO?> {
            return arrayOfNulls(size)
        }
    }

}