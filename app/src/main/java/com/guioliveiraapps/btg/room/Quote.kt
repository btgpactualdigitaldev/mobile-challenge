package com.guioliveiraapps.btg.room

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class Quote(
    @PrimaryKey(autoGenerate = true) val id: Int,
    @ColumnInfo(name = "initials") var initials: String,
    @ColumnInfo(name = "value") var value: Double
) {
    constructor(quote: Map.Entry<String, Double>) : this(0, quote.key, quote.value)
}