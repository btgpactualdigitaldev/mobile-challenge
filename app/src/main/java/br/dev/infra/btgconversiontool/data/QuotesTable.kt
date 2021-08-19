package br.dev.infra.btgconversiontool.data

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(
    tableName = "quotes_table"
)
data class QuotesTable(
    @ColumnInfo(name = "id") @PrimaryKey val id: String,
    @ColumnInfo(name = "source") val source: String,
    @ColumnInfo(name = "quote") val quote: Float
)