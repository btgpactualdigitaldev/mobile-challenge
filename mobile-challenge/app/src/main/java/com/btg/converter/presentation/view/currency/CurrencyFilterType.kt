package com.btg.converter.presentation.view.currency

sealed class CurrencyFilterType {
    object FilterByName : CurrencyFilterType()
    object FilterByCode : CurrencyFilterType()
}