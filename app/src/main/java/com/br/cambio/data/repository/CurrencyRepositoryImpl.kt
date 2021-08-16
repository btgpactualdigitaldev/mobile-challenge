package com.br.cambio.data.repository

import com.br.cambio.data.datasource.RemoteDataSource
import com.br.cambio.data.local.datasource.LocalDataSource
import com.br.cambio.domain.mapper.CurrencyToPresentationMapper
import com.br.cambio.domain.repository.CurrencyRepository
import com.br.cambio.presentation.mapper.ExchangePresentation

class CurrencyRepositoryImpl(
    private val remoteDataSource: RemoteDataSource,
    private val localDataSource: LocalDataSource
) : CurrencyRepository {

    private val mapper = CurrencyToPresentationMapper()

    override suspend fun getCurrencies(network: Boolean): ExchangePresentation {
        val remote = remoteDataSource.getCurrencies()

        remote?.let {
            localDataSource.insertCurrencies(remote)
        }

        return if (network) {
            mapper.map(remoteDataSource.getCurrencies())
        } else {
            mapper.map(localDataSource.getCurrencies())
        }
    }
}