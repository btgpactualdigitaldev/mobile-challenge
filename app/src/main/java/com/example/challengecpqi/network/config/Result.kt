package com.example.challengecpqi.network.config

import com.example.challengecpqi.model.response.ErrorResponse

sealed class Result<out T> {
    data class Success<out T>(val value: T): Result<T>()
    data class GenericError(val errorResponse: ErrorResponse? = null): Result<Nothing>()
    object NetworkError: Result<Nothing>()
}