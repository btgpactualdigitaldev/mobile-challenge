package com.gft.data.datasource

import com.gft.data.api.CurrencyApi
import com.gft.data.utils.SafeApiRequest
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValueList
import com.gft.domain.entities.Resource

class CurrencyRemoteDataSourceImpl(private val currencyApi: CurrencyApi) :
    CurrencyRemoteDataSource, SafeApiRequest() {

    override suspend fun getLabels(): Resource<CurrencyLabelList> {
        return apiRequest { currencyApi.getLabels() }
    }

    override suspend fun getValues(): Resource<CurrencyValueList> {
        return apiRequest { currencyApi.getValues() }
    }
}