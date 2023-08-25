package br.com.btg.mobile.challenge.data

import br.com.btg.mobile.challenge.data.model.Price
import br.com.btg.mobile.challenge.data.model.Rate

val PRICE_USD = Price(
    price = 1.0,
    coin = "USD"
)

val PRICE_BRL = Price(
    price = 0.2048,
    coin = "BRL"
)

val PRICE_EUR = Price(
    price = 1.0802,
    coin = "EUR"
)
val PRICES = listOf(PRICE_USD, PRICE_BRL, PRICE_EUR)

val RATE_BRL = Rate(
    exchangeRate = 4.8816,
    coin = "BRL"
)

val RATE_EUR = Rate(
    exchangeRate = 0.9229,
    coin = "EUR"
)

val RATE_GBP = Rate(
    exchangeRate = 0.7910,
    coin = "GBP"
)

val RATES = listOf(RATE_BRL, RATE_EUR, RATE_GBP)
