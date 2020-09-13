package br.com.rcp.currencyconverter.database.entities

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import java.io.Serializable

@Entity
data class Currency(
    @PrimaryKey var identifier  : String,
    @ColumnInfo var description : String,
    @ColumnInfo var value       : Double
) : Serializable