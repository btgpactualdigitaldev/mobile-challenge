package com.example.currencyconverter.entity

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Currency(
    val symbol: String,
    val name: String,
    var quote: Double): Parcelable {

    fun matchesQuery(query: String): Boolean {
        return (symbol.toLowerCase().contains(query.toLowerCase()) || name.toLowerCase().contains(query.toLowerCase()))
    }
}

