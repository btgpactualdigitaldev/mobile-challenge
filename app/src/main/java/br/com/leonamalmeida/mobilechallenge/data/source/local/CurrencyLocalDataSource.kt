package br.com.leonamalmeida.mobilechallenge.data.source.local

import br.com.leonamalmeida.mobilechallenge.data.source.local.dao.CurrencyDao
import br.com.leonamalmeida.mobilechallenge.data.Currency
import io.reactivex.Completable
import io.reactivex.Flowable

/**
 * Created by Leo Almeida on 27/06/20.
 */

interface CurrencyLocalDataSource {

    fun getCurrencies(keyToSearch: String, orderByName: Boolean): Flowable<List<Currency>>

    fun saveCurrencies(currencies: List<Currency>): Completable
}

class CurrencyLocalDataSourceImpl(private val currencyDao: CurrencyDao) :
    CurrencyLocalDataSource {

    override fun getCurrencies(
        keyToSearch: String,
        orderByName: Boolean
    ): Flowable<List<Currency>> =
        currencyDao.getCurrencies("%$keyToSearch%", orderByName)

    override fun saveCurrencies(currencies: List<Currency>): Completable =
        currencyDao.insertCurrencies(currencies)
}