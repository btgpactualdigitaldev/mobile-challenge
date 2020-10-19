package com.btgpactual.teste.mobile_challenge.data.local.entities

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.btgpactual.teste.mobile_challenge.data.remote.dto.CurrencyList

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Entity(tableName = "currency")
data class CurrencyEntity (
    @PrimaryKey
    val id: String,
    val desc: String
)