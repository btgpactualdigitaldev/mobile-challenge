package br.net.easify.currencydroid.database.model

import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

@Entity(tableName = "currency", indices = [Index(value = ["currencyId"], unique = true)])
data class Currency (

    @PrimaryKey(autoGenerate = true)
    var id: Long,
    var currencyId: String,
    var description: String
)