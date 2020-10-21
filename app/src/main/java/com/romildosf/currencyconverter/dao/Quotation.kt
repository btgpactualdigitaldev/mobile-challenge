package com.romildosf.currencyconverter.dao

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class Quotation(
    @PrimaryKey val pair: String,
    @ColumnInfo(name="value") val value: Double
)