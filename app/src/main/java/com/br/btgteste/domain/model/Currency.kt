package com.br.btgteste.domain.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Currency (
    val code: String,
    val name: String
) : Parcelable