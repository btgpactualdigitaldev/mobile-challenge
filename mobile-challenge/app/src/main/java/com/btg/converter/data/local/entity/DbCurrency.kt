package com.btg.converter.data.local.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.btg.converter.domain.entity.currency.Currency

@Entity(tableName = "currency")
data class DbCurrency(
    @PrimaryKey
    @ColumnInfo(name = "code")
    var code: String,
    @ColumnInfo(name = "name")
    var name: String
) {

    fun toDomainObject() = Currency(
        code = code,
        name = name
    )

    companion object {

        fun fromDomainObject(currency: Currency) = DbCurrency(
            code = currency.code,
            name = currency.name
        )
    }
}