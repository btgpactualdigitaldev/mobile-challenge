package com.vald3nir.data.database.model

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "exchange")
class Exchange(
    @PrimaryKey val id: Int? = null,
    @ColumnInfo(name = "quote") val quote: String?,
    @ColumnInfo(name = "value") val value: Double?,
)