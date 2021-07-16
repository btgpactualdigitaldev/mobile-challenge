package br.com.conversordemoedas.model

class QuotesManager {

    fun createQuotes(live: Live): Quotes {
        var quotes: Quotes? = null
        for (item in live.quotes){
            quotes = Quotes(item.key, item.value.toDouble())
        }
        return quotes!!
    }

}