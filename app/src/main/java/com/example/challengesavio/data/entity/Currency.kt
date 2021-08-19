package com.example.challengesavio.data.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "currency")
data class Currency(
    @PrimaryKey(autoGenerate = true)
    val uuid: Int?,
    @ColumnInfo(name = "currency_acronym")
    val acronym: String? = null,
    @ColumnInfo(name = "currency_name")
    val name: String? = null
)