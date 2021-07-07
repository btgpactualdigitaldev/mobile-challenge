package com.gft.presentation.entities

data class ConvertEntity(
    var from: String? = "USD",
    var to: String? = "BRL",
    var fromValue: Double,
    var toValue: Double
)