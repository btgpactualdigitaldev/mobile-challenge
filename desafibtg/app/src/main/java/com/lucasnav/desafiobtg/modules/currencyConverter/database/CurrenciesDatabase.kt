package com.lucasnav.desafiobtg.modules.currencyConverter.database

import android.annotation.SuppressLint
import android.util.Log
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Quote
import com.lucasnav.desafiobtg.modules.currencyConverter.model.RequestError
import io.reactivex.Completable
import io.reactivex.CompletableObserver
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.rxkotlin.toObservable
import io.reactivex.schedulers.Schedulers

class CurrenciesDatabase(
    private val currenciesDao: CurrenciesDao,
    private val quotesDao: QuotesDao
) {

    @SuppressLint("CheckResult")
    fun getCurrencies(
        onSuccess: (currencies: List<Currency>) -> Unit,
        onError: (error: RequestError) -> Unit
    ) {

        currenciesDao.getCurrencies()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({ currencies ->
                currencies?.let {
                    onSuccess(it)
                }
            }, {
                val requestError = RequestError(-1, it.message.toString())
                onError(requestError)
            })

    }

    fun saveCurrencies(currencies: List<Currency>) {

        Completable.fromAction {
            currenciesDao.deleteAndInsert(currencies)
        }.subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread())
            .subscribe(object : CompletableObserver {
                override fun onComplete() {
                    Log.d("SAVE-CURRENCIES", "SALVO COM SUCESSO")
                }

                override fun onSubscribe(d: Disposable) {
                }

                override fun onError(e: Throwable) {
                }
            })
    }

    @SuppressLint("CheckResult")
    fun searchCurrencies(
        query: String,
        onSuccess: (currencies: List<Currency>) -> Unit,
        onError: (error: String) -> Unit
    ) {
        val likeQuery = "%$query%"

        currenciesDao.searchCurrencies(likeQuery.trim())
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({ currencies ->
                currencies?.let {
                    onSuccess(it)
                }
            }, { error ->
                onError(error.message.toString())
            })
    }

    fun saveQuotes(quotes: List<Quote>) {

        Completable.fromAction {
            quotesDao.deleteAndInsert(quotes)
        }.subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread())
            .subscribe(object : CompletableObserver {
                override fun onComplete() {
                    Log.d("SAVE-QUOTES", "SALVO COM SUCESSO")
                }

                override fun onSubscribe(d: Disposable) {
                }

                override fun onError(e: Throwable) {
                    Log.d("ERROR-SAVE-QUOTES", "ERRO SAVE QUOTES")
                }
            })
    }

    @SuppressLint("CheckResult")
    fun getTwoQuotes(
        firstSymbol: String,
        secondSymbol: String,
        onSuccess: (quotes: List<Quote>) -> Unit,
        onError: (error: RequestError) -> Unit
    ) {
        val symbol1 = "USD${firstSymbol}"
        val symbol2 = "USD${secondSymbol}"

        quotesDao.getTwoQuotes(symbol1, symbol2)
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                    onSuccess(it)
            }, {
                val requestError = RequestError(-1, it.message.toString())
                onError(requestError)
            })
    }
}