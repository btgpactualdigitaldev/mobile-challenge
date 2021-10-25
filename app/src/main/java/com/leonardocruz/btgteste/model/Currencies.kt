package com.leonardocruz.btgteste.model
import java.io.Serializable

data class Currencies(
    val initials: String,
    val value: String
) : Serializable