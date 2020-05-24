package com.hotmail.fignunes.btg.di

import com.hotmail.fignunes.btg.presentation.currencies.CurrenciesContract
import com.hotmail.fignunes.btg.presentation.currencies.CurrenciesPresenter
import com.hotmail.fignunes.btg.presentation.quotedollar.QuoteDollarContract
import com.hotmail.fignunes.btg.presentation.quotedollar.QuoteDollarPresenter
import com.hotmail.fignunes.btg.presentation.splash.SplashContract
import com.hotmail.fignunes.btg.presentation.splash.SplashPresenter
import org.koin.dsl.module

object PresenterModule {

    val presenterModule = module {
        factory { (contract: QuoteDollarContract) -> QuoteDollarPresenter(contract, get(), get(), get(), get(), get(), get(), get()) }
        factory { (contract: CurrenciesContract) -> CurrenciesPresenter(contract, get(), get()) }
        factory { (contract: SplashContract) -> SplashPresenter(contract) }
    }
}