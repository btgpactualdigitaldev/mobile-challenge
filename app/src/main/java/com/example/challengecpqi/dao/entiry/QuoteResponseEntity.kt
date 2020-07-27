package com.example.challengecpqi.dao.entiry

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.example.challengecpqi.model.response.QuotesResponse
import java.io.Serializable

@Entity
data class QuoteResponseEntity (
    @PrimaryKey val id: Long = 1,
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val timestamp: Long,
    val source: String
) : Serializable

fun QuotesResponse.toQuoteResponseEntity(): QuoteResponseEntity {
    return with(this) {
        QuoteResponseEntity(
            privacy = this.privacy,
            success = this.success,
            terms = this.terms,
            source = this.source,
            timestamp = this.timestamp
        )
    }
}