package com.btgpactual.teste.mobile_challenge.data.local.entities

import androidx.room.Entity
import androidx.room.PrimaryKey

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Entity(tableName = "currency_value")
data class CurrencyValueEntity (
    @PrimaryKey
    val currency: String,
    val value: Double
)