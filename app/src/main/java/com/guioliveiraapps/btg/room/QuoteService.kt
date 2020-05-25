package com.guioliveiraapps.btg.room

import android.content.Context

object QuoteService {

    fun resetQuotes(context: Context, quotes: List<Quote>): List<Quote> {
        AppDatabase.getInstance(context).quoteDao().deleteAll()
        AppDatabase.getInstance(context).quoteDao().insertAll(quotes)
        return AppDatabase.getInstance(context).quoteDao().getAll()
    }

    fun getQuotes(context: Context): List<Quote> {
        return AppDatabase.getInstance(context).quoteDao().getAll()
    }
}