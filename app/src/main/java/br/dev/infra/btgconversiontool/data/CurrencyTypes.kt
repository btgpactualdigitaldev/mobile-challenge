package br.dev.infra.btgconversiontool.data

import androidx.room.DatabaseView

data class CurrencyList(
    val success: Boolean,
    val currencies: Map<*, String>
)

data class CurrencyQuotes(
    val success: Boolean,
    val source: String,
    val quotes: Map<*, Float>
)

@DatabaseView(
    "select a.id, a.description, b.quote from quotes_table  b inner join currency_table a on (a.id = b.id)"
)
data class CurrencyView(
    val id: String,
    val description: String,
    val quote: Float
)