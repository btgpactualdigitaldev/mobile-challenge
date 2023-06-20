package com.br.btgteste.data.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class ErrorPayload(val code : Int,val info : String) : Parcelable
