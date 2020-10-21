package com.romildosf.currencyconverter.util


sealed class Result<out T : Any> {

    data class Success<out T : Any>(val data: T) : Result<T>()
    data class Failure(val exception: Exception) : Result<Nothing>()

    val isSuccess: Boolean
        get() = this is Success

    val isFailure: Boolean
        get() = this is Failure

    val success: T?
        get() {
            if (this is Success) return data
            return null
        }

    val failure: Exception?
        get() {
            if (this is Failure) return this.exception
            return null
        }

    fun fold(onSuccess: (param: T) -> Unit, onFailure: (exception: Exception) -> Unit)  {
        success?.let { onSuccess.invoke(it) } ?: onFailure.invoke(failure!!)
    }

    override fun toString(): String {
        return when (this) {
            is Success<*> -> "Success[data=$data]"
            is Failure -> "Failure[exception=$exception]"
        }
    }
}