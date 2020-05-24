package com.hotmail.fignunes.btg.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Currency(
    var id: String,
    var description: String
) : Parcelable