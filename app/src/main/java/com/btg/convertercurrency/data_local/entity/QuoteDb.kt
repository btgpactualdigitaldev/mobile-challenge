package com.btg.convertercurrency.data_local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import androidx.room.TypeConverters
import com.btg.convertercurrency.data_local.entity.converters.DataTypeConverters
import java.time.OffsetDateTime

@Entity
data class QuoteDb(
    @PrimaryKey(autoGenerate = true)
    var id: Int? = null,
    val currencyDbId: Long,
    val code: String = "",
    val quote: String = "",
    val date: OffsetDateTime = OffsetDateTime.now()
) {}