package com.example.challengecpqi.dao.config

sealed class ResultLocal<out T> {
    data class Success<out T>(val value: T? = null): ResultLocal<T>()
    data class Error(val errorMsg: String? = null): ResultLocal<Nothing>()
}