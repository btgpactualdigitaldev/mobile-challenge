package com.gft.data.datasource

import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.Resource

interface CurrencyLocalDataSource {
    fun getAllLabels() : Resource<CurrencyLabelList>

    fun getValues() : Resource<CurrencyLabelList>
}