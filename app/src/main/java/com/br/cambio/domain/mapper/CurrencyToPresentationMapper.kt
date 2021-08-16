package com.br.cambio.domain.mapper

import com.br.cambio.customviews.DialogSpinnerModel
import com.br.cambio.domain.model.CurrencyDomain
import com.br.cambio.presentation.mapper.ExchangePresentation
import com.br.cambio.utils.Mapper

class CurrencyToPresentationMapper : Mapper<List<CurrencyDomain>?, ExchangePresentation> {

    override fun map(source: List<CurrencyDomain>?): ExchangePresentation {
        return when {
            source == null -> {
                ExchangePresentation.ErrorResponse
            }
            source.isEmpty() -> {
                ExchangePresentation.EmptyResponse
            }
            else -> {
                toPresentation(source)
            }
        }
    }

    private fun toPresentation(source: List<CurrencyDomain>): ExchangePresentation {
        return ExchangePresentation.SuccessResponse(
            source.map {
                DialogSpinnerModel(
                    codigo = it.key,
                    nome = it.value
                )
            }
        )
    }
}