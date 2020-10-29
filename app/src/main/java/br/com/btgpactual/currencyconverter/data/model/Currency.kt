package br.com.btgpactual.currencyconverter.data.model

data class Currency (
    val code: String,
    val name: String,
    val dateLastUpdate: Long,
    val quotation: Double?
)