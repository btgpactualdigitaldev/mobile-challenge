package com.guioliveiraapps.btg.room

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class Currency(
    @PrimaryKey(autoGenerate = true) val id: Int,
    @ColumnInfo(name = "initials") var initials: String,
    @ColumnInfo(name = "name") var name: String
) {
    constructor(currency: Map.Entry<String, String>) : this(0, currency.key, currency.value)

    override fun toString(): String {
        return "(${initials}) $name"
    }
}