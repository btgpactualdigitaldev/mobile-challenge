package academy.mukandrew.currencyconverter.domain.models

data class CurrencyQuote(
    val code: String,
    val quantity: Float,
    val value: Float
)