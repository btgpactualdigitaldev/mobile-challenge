package academy.mukandrew.currencyconverter.domain.models

data class Currency(
    val code: String,
    val name: String,
    var quote: CurrencyQuote? = null
)