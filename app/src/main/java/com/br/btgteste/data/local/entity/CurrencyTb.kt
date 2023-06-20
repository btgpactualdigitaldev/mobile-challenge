package com.br.btgteste.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "tb_currency")
data class CurrencyTb(
    @PrimaryKey(autoGenerate = true)
    var id: Int = 0,
    val code : String = "",
    val name : String = ""
)