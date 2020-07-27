package com.example.challengecpqi.dao.entiry

import androidx.room.Embedded
import androidx.room.Relation
import com.example.challengecpqi.dao.entiry.CurrencyEntity
import com.example.challengecpqi.dao.entiry.CurrencyResponseEntity

data class CurrencyResponseWithCurrency (
    @Embedded var currencyResponseEntity: CurrencyResponseEntity,
    @Relation(parentColumn = "id", entityColumn = "currencyResponseEntityId", entity = CurrencyEntity::class)
    var currencyEntities: List<CurrencyEntity>? = null
)