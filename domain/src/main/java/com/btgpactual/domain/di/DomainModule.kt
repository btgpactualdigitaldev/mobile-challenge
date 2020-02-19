package com.btgpactual.domain.di

import com.btgpactual.domain.usecases.GetCurrencyUseCase
import com.btgpactual.domain.usecases.ConvertUseCase
import io.reactivex.schedulers.Schedulers
import org.koin.dsl.module

val useCaseModule = module {
    factory {
        GetCurrencyUseCase(
            repository = get(),
            ioScheduler = Schedulers.io()
        )
    }

    factory {
        ConvertUseCase(
            repository = get(),
            ioScheduler = Schedulers.io()
        )
    }
}


val domainModule = listOf(useCaseModule)