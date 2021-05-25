package com.vald3nir.data.database.model

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "flag")
class Flag(
    @PrimaryKey val id: Int? = null,
    @ColumnInfo(name = "code") val code: String?,
    @ColumnInfo(name = "url") val url: String?,
)