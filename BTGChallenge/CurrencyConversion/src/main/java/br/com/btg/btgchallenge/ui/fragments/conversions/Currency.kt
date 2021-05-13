package br.com.btg.btgchallenge.ui.fragments.conversions

enum class CurrencyType {
    FROM,
    TO
}

interface CurrencyClicked
{
    fun currencyClicked(currency: Currency)
}

data class Currency(
    val currency: Pair<String, String>,
    val type: CurrencyType
) {
    constructor() : this(Pair("", ""), CurrencyType.FROM)
}