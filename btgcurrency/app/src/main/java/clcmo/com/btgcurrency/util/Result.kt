package clcmo.com.btgcurrency.util

import java.lang.Exception

sealed class Result<out T: Any?> {
    data class Success<T : Any>(val dataResult: T) : Result<T>()
    data class Failure(val dataError : Exception) : Result<Nothing>()
}