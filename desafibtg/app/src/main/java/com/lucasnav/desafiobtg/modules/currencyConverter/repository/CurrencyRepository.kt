package com.lucasnav.desafiobtg.modules.currencyConverter.repository

import android.content.Context
import android.util.Log
import com.lucasnav.desafiobtg.modules.currencyConverter.database.CurrenciesDatabase
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Quote
import com.lucasnav.desafiobtg.modules.currencyConverter.model.RequestError
import com.lucasnav.desafiobtg.modules.currencyConverter.networking.CurrencyNetworking
import com.lucasnav.desafiobtg.modules.currencyConverter.util.hasInternet

open class CurrencyRepository(
    private val currenciesDatabase: CurrenciesDatabase,
    private val context: Context
) {
    fun getCurrencies(
        onSuccess: (currencies: List<Currency>) -> Unit,
        onError: (error: RequestError) -> Unit
    ) {

        currenciesDatabase.getCurrencies(
            onSuccess,
            onError
        )

        CurrencyNetworking.getCurrenciesFromApi(
            onSuccess = { currenciesReponse ->
                currenciesDatabase.saveCurrencies(currenciesReponse)
                onSuccess(currenciesReponse)
            },
            onError = {
                onError(it)
            }
        )
    }

    fun searchCurrencies(
        query: String,
        onSuccess: (currencies: List<Currency>) -> Unit,
        onError: (error: String) -> Unit
    ) {
        currenciesDatabase.searchCurrencies(
            query,
            onSuccess = { onSuccess(it) },
            onError = { onError(it) }
        )
    }

    fun getQuotes(
        fisrtCurrency: String,
        secondCurrency: String,
        onSuccess: (quotes: List<Quote>) -> Unit,
        onError: (error: RequestError) -> Unit
    ) {

        if (hasInternet(context)) {
            CurrencyNetworking.getQuotesFromApi(
                fisrtCurrency,
                secondCurrency,
                onSuccess = { onSuccess(it) },
                onError = { onError(it) }
            )
        } else {
            currenciesDatabase.getTwoQuotes(
                fisrtCurrency,
                secondCurrency,
                onSuccess = {

                    if (it[0].symbol.substringAfter("USD") == secondCurrency) {
                        onSuccess(it.reversed())
                    } else {
                        onSuccess(it)
                    }
                },
                onError = { onError(it) }
            )
        }
    }

    fun getAllQuotesFromApiAndSave() {
        CurrencyNetworking.getQuotesFromApi(
            "",
            "",
            onSuccess = {
                currenciesDatabase.saveQuotes(it)
            },
            onError = {
                Log.d("ERROR-GET-QUOTES", it.info)
            }
        )
    }
}