package com.br.cambio.domain.mapper

import com.br.cambio.domain.model.PriceDomain
import com.br.cambio.presentation.mapper.QuotaPresentation
import com.br.cambio.presentation.model.PricePresentation
import com.br.cambio.utils.Mapper

class PriceToPresentationMapper : Mapper<List<PriceDomain>?, QuotaPresentation> {

    override fun map(source: List<PriceDomain>?): QuotaPresentation {
        return when {
            source == null -> {
                QuotaPresentation.ErrorResponse
            }
            source.isEmpty() -> {
                QuotaPresentation.EmptyResponse
            }
            else -> {
                toPresentation(source)
            }
        }
    }

    private fun toPresentation(source: List<PriceDomain>): QuotaPresentation {
        return QuotaPresentation.SuccessResponse(
            source.map {
                PricePresentation(
                    currency = it.key,
                    price = it.value
                )
            }
        )
    }
}