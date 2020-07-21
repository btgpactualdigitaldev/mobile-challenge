package com.btg.converter.data.repository

import com.btg.converter.data.local.dao.QuoteDao
import com.btg.converter.data.local.entity.DbQuote
import com.btg.converter.data.remote.client.ApiClient
import com.btg.converter.data.util.request.handleException
import com.btg.converter.domain.boundary.QuoteRepository
import com.btg.converter.domain.entity.quote.CurrentQuotes
import com.btg.converter.domain.entity.quote.Quote
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class DefaultQuoteRepository constructor(
    private val apiClient: ApiClient,
    private val quoteDao: QuoteDao
) : QuoteRepository {

    override suspend fun getCurrentQuotes(): CurrentQuotes? {
        return handleException(::getFromDatabase) {
            apiClient.getCurrentQuotes()?.toDomainObject()
                ?.also { saveQuotesIntoDatabase(it.quotes) }
        }
    }

    private suspend fun getFromDatabase(e: Throwable): CurrentQuotes? {
        val currentQuotes = quoteDao.getQuotes()
        if (currentQuotes.isNotEmpty()) {
            return CurrentQuotes(true, currentQuotes.map { it.toDomainObject() })
        } else {
            throw e
        }
    }

    private suspend fun saveQuotesIntoDatabase(quotes: List<Quote>) {
        withContext(Dispatchers.IO) {
            quoteDao.insertQuotes(quotes.map { DbQuote.fromDomainObject(it) })
        }
    }
}