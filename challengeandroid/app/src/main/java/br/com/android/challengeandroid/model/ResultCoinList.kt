package br.com.android.challengeandroid.model

data class ResultCoinList(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val currencies: Map<String, String>
)
