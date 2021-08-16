package com.br.cambio.presentation.mapper

import com.br.cambio.customviews.DialogSpinnerModel

sealed class ExchangePresentation {
    object ErrorResponse : ExchangePresentation()
    object EmptyResponse : ExchangePresentation()
    data class SuccessResponse(val items: List<DialogSpinnerModel>?) : ExchangePresentation()
}