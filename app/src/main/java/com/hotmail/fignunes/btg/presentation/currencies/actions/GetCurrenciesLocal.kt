package com.hotmail.fignunes.btg.presentation.currencies.actions

import com.hotmail.fignunes.btg.model.Currency
import com.hotmail.fignunes.btg.repository.Repository
import io.reactivex.Single

class GetCurrenciesLocal(private val repository: Repository) {

    fun execute(): Single<List<Currency>> {
        return repository.local.currency.getCurrencyAll().toSingle()
    }
}