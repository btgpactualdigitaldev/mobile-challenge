package br.net.easify.currencydroid.util

import br.net.easify.currencydroid.database.model.Currency
import br.net.easify.currencydroid.database.model.Quote

class DatabaseUtils {
    companion object {
        fun mapToCurrency(map: Map<String, String>): List<Currency> {
            val currencies: ArrayList<Currency> = arrayListOf()

            for (item in map) {
                currencies.add(
                    Currency(
                        0,
                        item.key,
                        item.value
                    )
                )
            }

            return currencies
        }

        fun mapToQuote(map: Map<String, Float>): List<Quote> {
            val currencies: ArrayList<Quote> = arrayListOf()

            for (item in map) {
                currencies.add(
                    Quote(
                        0,
                        item.key,
                        item.value
                    )
                )
            }

            return currencies
        }
    }
}