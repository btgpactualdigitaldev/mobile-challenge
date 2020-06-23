package com.example.currencyconverter.infrastructure.network

data class LiveAPIResponseModel(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val quotes: Map<String,Double>)