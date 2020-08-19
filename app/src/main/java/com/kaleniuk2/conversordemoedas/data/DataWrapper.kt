package com.kaleniuk2.conversordemoedas.data

sealed class DataWrapper<out T> {
    data class Success<out T>(val value: T): DataWrapper<T>()
    data class Error(val error: String? = null): DataWrapper<Nothing>()
}
