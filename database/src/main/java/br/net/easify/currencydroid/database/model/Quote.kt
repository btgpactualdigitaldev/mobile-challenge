package br.net.easify.currencydroid.database.model

import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

@Entity(tableName = "quote", indices = [Index(value = ["conversion"], unique = true)])
data class Quote (
    @PrimaryKey(autoGenerate = true)
    var id: Long,
    var conversion: String,
    var rate: Float
)