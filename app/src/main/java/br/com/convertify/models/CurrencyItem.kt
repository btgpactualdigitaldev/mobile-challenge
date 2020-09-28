package br.com.convertify.models

import android.os.Parcel
import android.os.Parcelable

data class CurrencyItem(val code: String?, val slug: String?, var baseTax: Double = 0.0) : Parcelable {

    constructor(parcel: Parcel) : this(
        parcel.readString(),
        parcel.readString(),
        parcel.readDouble()
    )

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(code)
        parcel.writeString(slug)
        parcel.writeDouble(baseTax)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<CurrencyItem> {

        fun fromMapEntry(value: Map.Entry<String, String>) =
            CurrencyItem(code = value.key, slug = value.value)

        override fun createFromParcel(parcel: Parcel): CurrencyItem {
            return CurrencyItem(parcel)
        }

        override fun newArray(size: Int): Array<CurrencyItem?> {
            return arrayOfNulls(size)
        }
    }
}