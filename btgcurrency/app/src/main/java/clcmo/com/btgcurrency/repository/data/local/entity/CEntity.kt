package clcmo.com.btgcurrency.repository.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "currency")
data class CEntity(@PrimaryKey val id: String, val name: String) {
    companion object {
        fun fromMapEntry(entry: Map.Entry<String, String>) = CEntity(entry.key, entry.value)
    }
}