package com.btgpactual.domain.usecases

import com.btgpactual.domain.entity.Currency
import com.btgpactual.domain.repository.CurrenciesRepository
import io.reactivex.Scheduler
import io.reactivex.Single

class GetCurrencyUseCase(
    private val repository : CurrenciesRepository,
    private val ioScheduler : Scheduler
) {

    fun execute(force: Boolean = true) : Single<List<Currency>>{
        return repository.getCurrencies(force).subscribeOn(ioScheduler)
    }
}