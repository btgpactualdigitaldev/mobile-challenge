package com.autopass.rechargeapp.repository.local

import android.content.Context
import com.autopass.rechargeapp.repository.local.attendant.LocalFactory
import com.hotmail.fignunes.btg.repository.local.LocalCurrencyRepository
import com.hotmail.fignunes.btg.repository.local.currency.entity.CurrencyDatabase
import com.hotmail.fignunes.btg.repository.local.currency.resources.LocalCurrencyResources
import org.koin.core.KoinComponent
import org.koin.core.inject

class LocalRepository(applicationContext: Context) : LocalFactory, KoinComponent {
    private val currencyDatabase: CurrencyDatabase by inject()

    override val currency: LocalCurrencyResources = LocalCurrencyRepository(currencyDatabase)
}