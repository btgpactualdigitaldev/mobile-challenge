package com.br.cambio.data.repository

import com.br.cambio.data.datasource.RemoteDataSource
import com.br.cambio.data.local.datasource.LocalDataSource
import com.br.cambio.domain.mapper.PriceToPresentationMapper
import com.br.cambio.domain.repository.PricesRepository
import com.br.cambio.presentation.mapper.QuotaPresentation

class PricesRepositoryImpl(
    private val remoteDataSource: RemoteDataSource,
    private val localDataSource: LocalDataSource
) : PricesRepository {

    private val mapper = PriceToPresentationMapper()

    override suspend fun getPrices(network: Boolean): QuotaPresentation {
        val remote = remoteDataSource.getPrices()

        remote?.let {
            localDataSource.insertPrices(remote)
        }


        return if (network) {
            mapper.map(remoteDataSource.getPrices())
        } else {
            mapper.map(localDataSource.getPrices())
        }
    }
}