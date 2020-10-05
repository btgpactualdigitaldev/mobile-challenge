package academy.mukandrew.currencyconverter.commons

import java.lang.Exception

sealed class Result<out T : Any> {
    data class Success<T : Any>(val data: T) : Result<T>()
    data class Failure(val error: Exception) : Result<Nothing>()
}