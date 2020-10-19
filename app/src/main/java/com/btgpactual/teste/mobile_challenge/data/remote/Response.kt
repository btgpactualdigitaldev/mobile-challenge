package com.btgpactual.teste.mobile_challenge.data.remote

/**
 * Created by Carlos Souza on 16,October,2020
 */
sealed class Response<T> (
    val status: Status,
    val data: T? = null,
    val message: String? = null
) {
    class Success<T>(data: T) : Response<T>(Status.SUCCESS, data)
    class Loading<T>(data: T? = null) : Response<T>(Status.LOADING, data)
    class Error<T>(message: String, data: T? = null) : Response<T>(Status.ERROR, data, message)
}

enum class Status { SUCCESS, ERROR, LOADING }