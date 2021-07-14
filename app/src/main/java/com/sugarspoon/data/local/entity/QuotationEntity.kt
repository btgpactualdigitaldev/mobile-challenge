package com.sugarspoon.data.local.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "quotation_table")
data class QuotationEntity (
    @PrimaryKey(autoGenerate = true)
    val id: Int,
    @ColumnInfo(name = "code") val code: String,
    @ColumnInfo(name = "value") val value: Float,
)