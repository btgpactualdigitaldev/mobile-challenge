package clcmo.com.btgcurrency.repository.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "currency_quote")
data class QEntity(@PrimaryKey val id: String, val value: Float) {
    companion object {
        fun fromMapEntry(entry: Map.Entry<String, Float>) = QEntity(entry.key, entry.value)
    }
}