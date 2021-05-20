package br.com.albertomagalhaes.btgcurrencies.dto

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.Ignore
import androidx.room.PrimaryKey
import java.math.BigDecimal

@Entity(tableName = "currency")
data class CurrencyDTO(
    @PrimaryKey(autoGenerate = true)
    val id: Int? = null,
    val code: String,
    val name: String,
    val value: Double,
    val timestamp: Long,
    @ColumnInfo(name = "is_selected")
    var isSelected: Boolean = false
){
    @Ignore
    var convertedValue: BigDecimal = BigDecimal(0.0)
}