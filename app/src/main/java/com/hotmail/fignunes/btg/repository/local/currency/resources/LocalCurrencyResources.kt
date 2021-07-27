package com.hotmail.fignunes.btg.repository.local.currency.resources

import com.hotmail.fignunes.btg.model.Currency
import io.reactivex.Completable
import io.reactivex.Maybe

interface LocalCurrencyResources {
    fun getCurrencyAll(): Maybe<List<Currency>>
    fun saveCurrency(currency: List<Currency>): Completable
    fun deleteAll(): Completable
}