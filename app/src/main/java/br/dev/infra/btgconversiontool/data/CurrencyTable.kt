package br.dev.infra.btgconversiontool.data

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(
    tableName = "currency_table"
)
data class CurrencyTable(
    @ColumnInfo(name = "id") @PrimaryKey val id: String,
    @ColumnInfo(name = "description") val description: String
)

