package com.mbarros64.btg_challenge.database.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "currency_table")
data class Currency(
    @PrimaryKey
    @ColumnInfo(name="currency") var currency : String,
    @ColumnInfo(name="rate") var rate : Double,
    @ColumnInfo(name="currencyName") var currencyName : String,
)