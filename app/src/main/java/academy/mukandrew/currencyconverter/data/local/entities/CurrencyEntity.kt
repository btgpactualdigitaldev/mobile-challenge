package academy.mukandrew.currencyconverter.data.local.entities

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "currency")
data class CurrencyEntity(
    @PrimaryKey val code: String,
    val name: String
) {
    companion object {
        fun fromMapEntry(entry: Map.Entry<String, String>): CurrencyEntity {
            return CurrencyEntity(entry.key, entry.value)
        }
    }
}