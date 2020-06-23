package com.example.currencyconverter.presentation.converter

import android.view.View

interface ConverterView {
    fun setOriginalValueText(text: String)
    fun onOriginalCurrencyButtonClick(view : View)
    fun onConvertedCurrencyButtonClick(view: View)
    fun onConvertButtonClick(view: View)
    fun setOriginalCurrencyButtonText(text : String)
    fun setConvertedCurrencyButtonText(text : String)
    fun setConvertedValueText(text : String)
    fun showCurrencyList(requestCode : Int)
}