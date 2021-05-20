package com.renderson.currency_converter.models

import java.io.Serializable

data class Currency(
    val initials: String,
    val name: String
): Serializable