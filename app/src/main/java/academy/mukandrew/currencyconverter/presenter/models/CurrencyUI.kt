package academy.mukandrew.currencyconverter.presenter.models

import academy.mukandrew.currencyconverter.domain.models.Currency

data class CurrencyUI(
    val code: String,
    val name: String
) {

    companion object {
        fun fromEntity(currency: Currency): CurrencyUI {
            return CurrencyUI(currency.code, currency.name)
        }
    }
}