package com.geocdias.convecurrency.util

enum class Status {
    SUCCESS,
    ERROR,
    LOADING
}

data class Resource<T>(val status: Status, val data: T?, val message: String?) {

    companion object {
        fun <T> success(data: T?): Resource<T> = Resource(Status.SUCCESS, data,  null)
        fun <T> error(message: String): Resource<T> = Resource(Status.ERROR, null, message)
        fun <T> loading(data: T? = null): Resource<T> = Resource(Status.LOADING, data,null)
    }
}
