package com.example.currencies.model.room

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "Rates")
class RatesModelLocal {
    @PrimaryKey(autoGenerate = false)
    @ColumnInfo(name = "abbrev")
    var abbrev: String = ""

    @ColumnInfo(name = "price")
    var price: Double = 0.0
}
