package com.hotmail.fignunes.btg.repository.local

import com.hotmail.fignunes.btg.model.Currency
import com.hotmail.fignunes.btg.repository.local.currency.entity.CurrencyDatabase
import com.hotmail.fignunes.btg.repository.local.currency.mappers.SetCurrency
import com.hotmail.fignunes.btg.repository.local.currency.mappers.SetCurrencyBean
import com.hotmail.fignunes.btg.repository.local.currency.resources.LocalCurrencyResources
import io.reactivex.Completable
import io.reactivex.Maybe

class LocalCurrencyRepository(private val currencyDatabase: CurrencyDatabase) : LocalCurrencyResources {

    override fun getCurrencyAll(): Maybe<List<Currency>> = currencyDatabase.currencyDao().getCurrencyBean()
        .map { SetCurrencyBean().toCurrency(it) }

    override fun saveCurrency(currency: List<Currency>): Completable = Completable.fromCallable {
        currencyDatabase.currencyDao().insert(SetCurrency().toCurrencyBean(currency))
    }

    override fun deleteAll(): Completable = Completable.fromCallable {
        currencyDatabase.currencyDao().deleteAll()
    }
}