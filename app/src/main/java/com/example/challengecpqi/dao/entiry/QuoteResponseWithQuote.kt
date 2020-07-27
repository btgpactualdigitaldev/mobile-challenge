package com.example.challengecpqi.dao.entiry

import androidx.room.Embedded
import androidx.room.Relation
import com.example.challengecpqi.dao.entiry.QuoteEntity
import com.example.challengecpqi.dao.entiry.QuoteResponseEntity

data class QuoteResponseWithQuote (
    @Embedded var quoteResponseEntity: QuoteResponseEntity,
    @Relation(parentColumn = "id", entityColumn = "quoteResponseEntityId", entity = QuoteEntity::class)
    var quoteEntities: List<QuoteEntity>? = null
)