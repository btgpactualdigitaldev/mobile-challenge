package com.btgpactual.currencyconverter.data.framework.roomdatabase.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.btgpactual.currencyconverter.data.model.CurrencyModel

@Entity(tableName = "currency")
data class CurrencyEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,
    val codigo: String,
    val nome: String,
    val cotacao: Double?,
    val dataHoraUltimaAtualizacao: Long
)

fun CurrencyModel.toCurrencyEntity():CurrencyEntity{
    return with(this){
        CurrencyEntity(
            codigo = this.codigo,
            nome = this.nome,
            cotacao = this.cotacao,
            dataHoraUltimaAtualizacao = this.dataHoraUltimaAtualizacao
        )
    }
}

fun CurrencyEntity.toCurrencyModel():CurrencyModel{
    return CurrencyModel(
        codigo = this.codigo,
        nome = this.nome,
        cotacao = this.cotacao,
        dataHoraUltimaAtualizacao = this.dataHoraUltimaAtualizacao
    )
}