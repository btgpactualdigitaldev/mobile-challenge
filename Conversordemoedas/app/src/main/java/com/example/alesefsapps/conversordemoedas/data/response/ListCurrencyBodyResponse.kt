package com.example.alesefsapps.conversordemoedas.data.response

data class ListCurrencyBodyResponse (
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val currencies: HashMap<String, String>
)