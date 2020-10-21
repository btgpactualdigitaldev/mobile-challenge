package com.romildosf.currencyconverter.dao

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class Currency(
    @PrimaryKey val symbol: String,
    @ColumnInfo(name="full_name") val fullName: String
)