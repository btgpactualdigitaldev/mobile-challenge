package com.example.currencies.model.room

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "Currencies")
class CurrenciesModelLocal {

    @PrimaryKey(autoGenerate = false)
    @ColumnInfo(name = "abbrev")
    var abbrev: String = ""

    @ColumnInfo(name = "currency")
    var currency: String = ""
}