package com.btg.convertercurrency.data_local.entity

import androidx.room.Embedded
import androidx.room.Relation

class CurrencyDbWithQuotiesDb(

    @Embedded val currencyDb: CurrencyDb,
    @Relation(
        parentColumn = "id",
        entityColumn = "currencyDbId"
    )
    val quoteDb:  List<QuoteDb>
)