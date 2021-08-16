package com.br.cambio.presentation.mapper

import com.br.cambio.presentation.model.PricePresentation

sealed class QuotaPresentation {
    object ErrorResponse : QuotaPresentation()
    object EmptyResponse : QuotaPresentation()
    data class SuccessResponse(val items: List<PricePresentation>?) : QuotaPresentation()
}