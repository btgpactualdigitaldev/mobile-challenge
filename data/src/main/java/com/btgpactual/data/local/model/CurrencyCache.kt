package com.btgpactual.data.local.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "tbl_currency")
data class CurrencyCache(
    @PrimaryKey(autoGenerate = true)
    var id: Int =0,
    val code : String = "",
    val name : String = ""
)