package com.btgpactual.currencyconverter.data.model

data class CurrencyModel(
    val codigo: String,
    val nome: String,
    val cotacao: Double?,
    val dataHoraUltimaAtualizacao: Long
)