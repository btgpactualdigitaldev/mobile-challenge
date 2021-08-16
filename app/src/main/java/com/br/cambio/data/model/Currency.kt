package com.br.cambio.data.model

import android.os.Parcelable
import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.android.parcel.Parcelize

@Entity
@Parcelize
data class Currency (
    @PrimaryKey val key: String,
    val value: String
): Parcelable