package br.com.convertify.models

import android.os.Parcel
import android.os.Parcelable

data class QuotationItem(
    val code: String?,
    var value: Double = 0.0
) {
    private val currencyCodeLength = 3
    lateinit var sourceCurrency: String
    lateinit var targetCurrency: String

    init {
        code?.chunked(currencyCodeLength)?.run {
            sourceCurrency = this.first()
            targetCurrency = this.last()
        }
    }

    companion object{
        fun fromMapEntry(value: Map.Entry<String, Double>) =
            QuotationItem(code = value.key, value = value.value)
    }
}