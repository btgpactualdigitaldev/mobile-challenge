package com.desafio.btgpactual.shared.models

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class CurrencyModel(
    @PrimaryKey
    val code: String,
    val country: String
){
    override fun toString(): String {
        return "$code - $country"
    }
}