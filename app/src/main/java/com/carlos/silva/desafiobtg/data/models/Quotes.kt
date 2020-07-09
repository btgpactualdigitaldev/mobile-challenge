package com.carlos.silva.desafiobtg.data.models

data class Quotes (
    val success: Boolean = false,
    val terms: String = "",
    val privacy: String = "",
    val timestamp: Long = 0,
    val source: String = "",
    val quotes: Any? = null
)