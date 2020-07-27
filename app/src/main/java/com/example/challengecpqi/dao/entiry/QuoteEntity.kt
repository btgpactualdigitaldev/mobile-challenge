package com.example.challengecpqi.dao.entiry

import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey
import com.example.challengecpqi.model.Quote
import java.io.Serializable

@Entity
data class QuoteEntity (
    @ForeignKey(entity = QuoteResponseEntity::class,
        parentColumns = ["id"],
        childColumns = ["quoteResponseEntityId"],
        onUpdate = ForeignKey.CASCADE,
        onDelete = ForeignKey.CASCADE
    )
    var quoteResponseEntityId: Long? = null,
    @PrimaryKey val key: String,
    val value: Double
) : Serializable

fun Quote.toQuoteEntity(): QuoteEntity {
    return with(this) {
        QuoteEntity(
            key = this.key,
            value = this.value
        )
    }
}

fun QuoteEntity.toQuote(): Quote {
    return with(this) {
        Quote(
            key = this.key,
            value = this.value
        )
    }
}