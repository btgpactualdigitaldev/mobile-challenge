package com.gft.data.datasource

import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValueList
import com.gft.domain.entities.Resource

interface CurrencyRemoteDataSource {
    suspend fun getLabels() : Resource<CurrencyLabelList>

    suspend fun getValues() : Resource<CurrencyValueList>
}