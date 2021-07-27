package com.btg.teste.repository.dataManager.entity;

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "CURRENCIES")
data class CurrenciesEntity(
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "ID")
    var id: Int = 0,

    @ColumnInfo(name = "CURRENCY")
    var currency: String = "",

    @ColumnInfo(name = "NAME")
    var name: String = "",

    @ColumnInfo(name = "VALUE")
    var value: Double = 0.0
)