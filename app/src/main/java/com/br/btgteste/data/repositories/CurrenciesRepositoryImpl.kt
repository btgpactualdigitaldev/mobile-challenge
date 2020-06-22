package com.br.btgteste.data.repositories

import com.br.btgteste.data.model.CurrencyLiveDTO
import com.br.btgteste.data.remote.CurrencyApi
import com.br.btgteste.domain.repository.CurrenciesRepository

class CurrenciesRepositoryImpl(private val requests: CurrencyApi): CurrenciesRepository {

    override suspend fun getCurrencies() = requests.getCurrencyList()

    override suspend fun convertCurrencies(): CurrencyLiveDTO = requests.getCurrencyLive()
}