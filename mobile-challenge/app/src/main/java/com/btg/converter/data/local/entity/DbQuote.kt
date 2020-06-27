package com.btg.converter.data.local.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.btg.converter.domain.entity.quote.Quote

@Entity(tableName = "quote")
data class DbQuote(
    @PrimaryKey
    @ColumnInfo(name = "code")
    var currencyCode: String,
    @ColumnInfo(name = "value")
    var convertedValue: Double
) {

    fun toDomainObject() = Quote(
        currencyCode = currencyCode,
        convertedValue = convertedValue
    )

    companion object {

        fun fromDomainObject(quote: Quote) = DbQuote(
            currencyCode = quote.currencyCode,
            convertedValue = quote.convertedValue
        )
    }
}