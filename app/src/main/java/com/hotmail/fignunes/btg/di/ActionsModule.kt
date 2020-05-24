package com.hotmail.fignunes.btg.di

import com.hotmail.fignunes.btg.common.StringHelper
import com.hotmail.fignunes.btg.presentation.common.CheckIsOnline
import com.hotmail.fignunes.btg.presentation.common.ReadInstanceProperty
import com.hotmail.fignunes.btg.presentation.currencies.actions.GetCurrenciesLocal
import com.hotmail.fignunes.btg.presentation.quotedollar.actions.GetCurrencies
import com.hotmail.fignunes.btg.presentation.quotedollar.actions.GetQuoteDollar
import com.hotmail.fignunes.btg.presentation.quotedollar.actions.ResponsesToCurrency
import com.hotmail.fignunes.btg.presentation.quotedollar.actions.SaveCurrencies
import org.koin.android.ext.koin.androidContext
import org.koin.dsl.module

object ActionsModule {

    val actionsModule = module {

        factory { GetQuoteDollar(get()) }
        factory { CheckIsOnline(androidContext()) }
        factory { GetCurrencies(get()) }
        factory { SaveCurrencies(get()) }
        factory { ResponsesToCurrency(get()) }
        factory { GetCurrenciesLocal(get()) }
        factory { StringHelper(androidContext()) }
        factory { ReadInstanceProperty() }
    }
}