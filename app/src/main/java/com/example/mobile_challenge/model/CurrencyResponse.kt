package com.example.mobile_challenge.model

import kotlinx.serialization.Serializable

@Serializable
class CurrencyResponse(
  val success: Boolean,
  val terms: String,
  val privacy: String,
  val currencies: Map<String, String>
)