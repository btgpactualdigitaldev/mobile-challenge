package com.btg.convertercurrency.data_local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.time.OffsetDateTime

@Entity
class CurrencyDb(
    @PrimaryKey() var id: Long,
    val code: String,
    val name: String,
    val lastUpdate : OffsetDateTime = OffsetDateTime.now()
)