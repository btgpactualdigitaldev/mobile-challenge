package com.btg.converter.domain.boundary

import com.btg.converter.domain.entity.currency.CurrencyList
import com.btg.converter.domain.entity.quote.CurrentQuotes

interface QuoteRepository {

    suspend fun getCurrentQuotes(): CurrentQuotes?
}