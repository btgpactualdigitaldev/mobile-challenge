package com.btgpactual.domain.entity

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Quote(
    val code : String,
    val value : Double
) :  Parcelable
