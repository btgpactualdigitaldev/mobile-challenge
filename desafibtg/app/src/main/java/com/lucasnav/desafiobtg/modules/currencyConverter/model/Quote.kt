package com.lucasnav.desafiobtg.modules.currencyConverter.model

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.google.gson.annotations.SerializedName

@Entity(tableName = "quotes")
data class Quote(

    @PrimaryKey(autoGenerate = true)
    @field:SerializedName("id")
    var id: Int,

    @field:SerializedName("symbol")
    val symbol: String,

    @field:SerializedName("value")
    val value: Double
)