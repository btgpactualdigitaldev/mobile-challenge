package com.btg.convertercurrency.features.base_entity

import java.time.OffsetDateTime

data class QuoteItem(
    val code: String = "",
    var currencyId : Long = 0,
    val quote: String = "",
    val date: OffsetDateTime = OffsetDateTime.now()
)