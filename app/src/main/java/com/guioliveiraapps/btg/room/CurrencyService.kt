package com.guioliveiraapps.btg.room

import android.content.Context

object CurrencyService {

    fun resetCurrencies(context: Context, currencies: List<Currency>): List<Currency> {
        AppDatabase.getInstance(context).currencyDao().deleteAll()
        AppDatabase.getInstance(context).currencyDao().insertAll(currencies)
        return AppDatabase.getInstance(context).currencyDao().getAll()
    }

    fun getCurrencies(context: Context): List<Currency> {
        return AppDatabase.getInstance(context).currencyDao().getAll()
    }
}