package com.desafio.btgpactual.shared.models

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class QuotesModel(
    @PrimaryKey
    val code: String,
    val value: Double
)

