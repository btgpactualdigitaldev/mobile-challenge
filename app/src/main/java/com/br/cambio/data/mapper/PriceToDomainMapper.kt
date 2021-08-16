package com.br.cambio.data.mapper

import com.br.cambio.data.model.Price
import com.br.cambio.domain.model.PriceDomain
import com.br.cambio.utils.Mapper

class PriceToDomainMapper : Mapper<Price, PriceDomain> {

    override fun map(source: Price): PriceDomain {
        return PriceDomain(
            key = source.key.orEmpty(),
            value = source.value
        )
    }
}