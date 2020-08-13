package com.curymorais.moneyconversion.currencyConversion

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider


class ConversionViewModelFactory(private val coin: String) : ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(ConversionFragmentViewModel::class.java)) {
            return ConversionFragmentViewModel(coin) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}