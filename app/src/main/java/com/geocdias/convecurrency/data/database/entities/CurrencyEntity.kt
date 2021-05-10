package com.geocdias.convecurrency.data.database.entities

import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey
import com.geocdias.convecurrency.model.CurrencyModel

@Entity(tableName = "currency", indices = [Index(value = ["code"], unique = true)])
data class CurrencyEntity(
    @PrimaryKey(autoGenerate = true)
    var id: Int = 0,
    var code: String,
    var name: String
 )
