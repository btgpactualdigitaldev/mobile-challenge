package com.geocdias.convecurrency.data.database.entities

import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

@Entity(
    tableName = "exchange_rate",
    indices = [Index(value = ["quote"], unique = true)]
)
data class ExchangeRateEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val quote: String,
    val rate: Double
)
