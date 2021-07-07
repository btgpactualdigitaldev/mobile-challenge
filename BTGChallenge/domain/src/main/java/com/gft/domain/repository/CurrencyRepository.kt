package com.gft.domain.repository

import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValueList
import com.gft.domain.entities.Resource

interface CurrencyRepository {
    suspend fun getLabels(): Resource<CurrencyLabelList>

    suspend fun getValues(): Resource<CurrencyValueList>
}