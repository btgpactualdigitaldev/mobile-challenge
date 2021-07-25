package com.example.mobile_challenge.model

import kotlinx.serialization.Serializable

@Serializable
class ErrorResponse(
  val success: Boolean,
  val error: ErrorInfo
)

@Serializable
data class ErrorInfo(
  val code: Int,
  val type: String,
  val info: String
)