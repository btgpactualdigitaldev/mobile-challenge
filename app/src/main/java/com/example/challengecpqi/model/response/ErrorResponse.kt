package com.example.challengecpqi.model.response

import com.example.challengecpqi.model.Error

data class ErrorResponse (
    val success: Boolean = false,
    val error: Error
)