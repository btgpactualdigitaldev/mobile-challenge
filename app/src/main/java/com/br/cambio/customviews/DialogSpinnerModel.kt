package com.br.cambio.customviews

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class DialogSpinnerModel(
    var codigo: String,
    var nome: String
): Parcelable