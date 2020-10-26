package com.marcoaureliobueno.converterbtg.model

import android.os.Parcel
import android.os.Parcelable

class Currency() :  Parcelable {
    var code : String = ""
    var name : String = ""

    constructor(parcel: Parcel) : this() {
        code = parcel.readString().toString()
        name = parcel.readString().toString()
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(code)
        parcel.writeString(name)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<Currency> {
        override fun createFromParcel(parcel: Parcel): Currency {
            return Currency(parcel)
        }

        override fun newArray(size: Int): Array<Currency?> {
            return arrayOfNulls(size)
        }
    }


}