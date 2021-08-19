package com.example.challengesavio.data.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "quote")
data class Quote(
    @PrimaryKey(autoGenerate = true)
    val uuid: Int?,
    @ColumnInfo(name = "quote_conversion")
    val acronym: String? = null,
    @ColumnInfo(name = "quote_value")
    val value: Double? = null
)