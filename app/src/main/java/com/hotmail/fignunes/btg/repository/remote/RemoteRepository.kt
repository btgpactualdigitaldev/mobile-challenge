package com.hotmail.fignunes.btg.repository.remote

import com.hotmail.fignunes.btg.repository.remote.currencies.RemoteCurrenciesRepository
import com.hotmail.fignunes.btg.repository.remote.currencies.resources.RemoteCurrenciesResources
import com.hotmail.fignunes.btg.repository.remote.currencies.services.CurrenciesServices
import com.hotmail.fignunes.btg.repository.remote.quotedollar.RemoteQuoteDollarRepository
import com.hotmail.fignunes.btg.repository.remote.quotedollar.resources.RemoteQuoteDollarResources
import com.hotmail.fignunes.btg.repository.remote.quotedollar.services.QuoteDollarServices
import org.koin.core.KoinComponent
import org.koin.core.inject

class RemoteRepository : RemoteFactory, KoinComponent {

    private val quoteDollarServices: QuoteDollarServices by inject()
    private val currenciesServices: CurrenciesServices by inject()

    override val quoteDollar: RemoteQuoteDollarResources = RemoteQuoteDollarRepository(quoteDollarServices)
    override val currencies: RemoteCurrenciesResources = RemoteCurrenciesRepository(currenciesServices)

}