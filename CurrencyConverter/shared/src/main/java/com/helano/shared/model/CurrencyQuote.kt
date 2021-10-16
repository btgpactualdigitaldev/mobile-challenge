package com.helano.shared.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "quotes")
data class CurrencyQuote(
    @PrimaryKey
    val code: String,
    val value: Float
)