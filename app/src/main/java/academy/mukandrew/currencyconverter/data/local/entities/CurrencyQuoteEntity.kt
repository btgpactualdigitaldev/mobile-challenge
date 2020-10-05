package academy.mukandrew.currencyconverter.data.local.entities

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "currency_quote")
data class CurrencyQuoteEntity(
    @PrimaryKey val code: String,
    val value: Float
) {
    companion object {
        fun fromMapEntry(entry: Map.Entry<String, Float>): CurrencyQuoteEntity {
            return CurrencyQuoteEntity(entry.key, entry.value)
        }
    }
}