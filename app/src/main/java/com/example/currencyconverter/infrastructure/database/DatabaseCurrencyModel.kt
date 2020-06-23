package com.example.currencyconverter.infrastructure.database

import io.realm.RealmObject
import io.realm.annotations.PrimaryKey

open class DatabaseCurrencyModel (
    @PrimaryKey
    var symbol: String = "",
    var name: String = "",
    var quote: Double = 0.0
) : RealmObject()
