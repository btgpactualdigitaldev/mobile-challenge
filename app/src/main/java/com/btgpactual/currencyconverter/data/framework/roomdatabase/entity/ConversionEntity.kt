package com.btgpactual.currencyconverter.data.framework.roomdatabase.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "conversion")
data class ConversionEntity(
    val moedaInicialCodigo: String,
    val moedaFinalCodigo: String,
    val valorMoedaInicial: String,
    val valorMoedaFinal: String,
    val dataHora: Long,
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0
)
