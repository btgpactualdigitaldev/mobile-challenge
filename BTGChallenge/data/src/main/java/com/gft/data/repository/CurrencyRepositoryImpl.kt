package com.gft.data.repository

import com.gft.data.datasource.CurrencyLocalDataSource
import com.gft.data.datasource.CurrencyRemoteDataSource
import com.gft.data.utils.SafeApiRequest
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValueList
import com.gft.domain.entities.Resource
import com.gft.domain.repository.CurrencyRepository

class CurrencyRepositoryImpl(
    private val currencyLocalDataSource: CurrencyLocalDataSource,
    private val currencyRemoteDataSource: CurrencyRemoteDataSource
) : CurrencyRepository, SafeApiRequest() {
    override suspend fun getLabels(): Resource<CurrencyLabelList> {
        return currencyRemoteDataSource.getLabels()
    }

    override suspend fun getValues(): Resource<CurrencyValueList> {
        return currencyRemoteDataSource.getValues()
    }
}