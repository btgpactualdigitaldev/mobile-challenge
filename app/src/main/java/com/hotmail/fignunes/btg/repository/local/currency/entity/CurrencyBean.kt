package com.hotmail.fignunes.btg.repository.local.currency.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = CurrencyBean.TABLE)
data class CurrencyBean (

    @PrimaryKey
    val id: String,
    val description: String
) {
    companion object {
        const val TABLE = "currency_table"
    }
}