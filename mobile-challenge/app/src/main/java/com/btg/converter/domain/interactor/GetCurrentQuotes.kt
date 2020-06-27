package com.btg.converter.domain.interactor

import com.btg.converter.domain.boundary.QuoteRepository


class GetCurrentQuotes constructor(
    private val quoteRepository: QuoteRepository
) {

    suspend fun execute() = quoteRepository.getCurrentQuotes()
}