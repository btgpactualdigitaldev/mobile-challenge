package com.hotmail.fignunes.btg.presentation.quotedollar.actions

import com.hotmail.fignunes.btg.model.Currency
import com.hotmail.fignunes.btg.repository.Repository
import io.reactivex.Single

class SaveCurrencies(private val repository: Repository) {

    fun execute(currency: List<Currency>) : Single<Unit> {
        return repository.local.currency.saveCurrency(currency).toSingleDefault(Unit)
    }
}