package br.com.android.challengeandroid.model

data class ResultCoinPrice(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    //val timestamp: Int,
    val source: String,
    val quotes: Map<String, Double>
)
