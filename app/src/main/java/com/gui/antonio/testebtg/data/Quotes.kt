package com.gui.antonio.testebtg.data

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.google.gson.annotations.Expose

import com.google.gson.annotations.SerializedName
import java.math.BigDecimal

@Entity(tableName = "quotes")
class Quotes(
    @PrimaryKey(autoGenerate = true) var id: Int? = null,
    val symbol: String,
    val value: Double
)