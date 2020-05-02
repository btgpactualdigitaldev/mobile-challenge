package io.felipeandrade.domain

import java.math.BigDecimal

data class QuoteModel(
    val origin: String,
    val target: String,
    val factor: BigDecimal
)