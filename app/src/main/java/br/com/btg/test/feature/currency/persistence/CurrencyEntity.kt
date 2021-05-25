package br.com.btg.test.feature.currency.persistence

import android.os.Parcelable
import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.android.parcel.Parcelize

@Entity
@Parcelize
data class CurrencyEntity(
    @PrimaryKey val code: String,
    @ColumnInfo(name = "name") val name: String?
) : Parcelable