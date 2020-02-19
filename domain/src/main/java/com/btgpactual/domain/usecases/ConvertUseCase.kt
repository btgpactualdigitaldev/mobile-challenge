package com.btgpactual.domain.usecases

import com.btgpactual.domain.entity.Currency
import com.btgpactual.domain.repository.CurrenciesRepository
import io.reactivex.Scheduler
import io.reactivex.Single

class ConvertUseCase(
    private val repository: CurrenciesRepository,
    private val ioScheduler: Scheduler
){
    fun execute(value : Double, from: Currency, to : Currency) : Single<Double> {
        return repository.convert(value,from,to).subscribeOn(ioScheduler)
    }
}