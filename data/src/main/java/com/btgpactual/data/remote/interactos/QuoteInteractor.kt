package com.btgpactual.data.remote.interactos

import com.btgpactual.domain.entity.Currency
import com.btgpactual.domain.entity.Quote

object QuoteInteractor{

    fun convert(amount: Double,from: Currency, to : Currency, quotes:  List<Quote>) : Double{
        val amountInDolars = convertToDolar(amount,from,quotes)
        val quote =  quotes.filter {
            it.code.contentEquals("USD${to.code}")
        }.map { it.value }.firstOrNull() ?: 0.0

        return amountInDolars * quote
    }



    private fun convertToDolar(amount: Double,from: Currency, quotes : List<Quote>) : Double{
         return quotes.filter {it.code.contentEquals("USD${from.code}")}
            .map {
                amount / it.value
            }.firstOrNull() ?: 0.0
    }

}