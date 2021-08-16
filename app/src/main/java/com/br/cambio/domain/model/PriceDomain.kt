package com.br.cambio.domain.model

import android.os.Parcelable
import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.android.parcel.Parcelize

@Entity(tableName = "Price")
@Parcelize
data class PriceDomain(
    @PrimaryKey val key: String,
    val value: Double
): Parcelable