package com.sugarspoon.data.remote.model

data class RealTimeRatesResponse (
    val timestamp: Float,
    val quotes: HashMap<String, Float>
)