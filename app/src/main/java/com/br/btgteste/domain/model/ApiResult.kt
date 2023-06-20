package com.br.btgteste.domain.model

sealed class ApiResult<T>{
    data class Success<T>(var data: T) : ApiResult<T>()
    data class Error<T>(val throwable: Throwable): ApiResult<T>()
}