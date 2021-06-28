package br.com.gft.main

class Resource<T> private constructor(
    val status: Status,
    val data: T? = null,
    val exception: Throwable? = null
) {

    enum class Status {
        SUCCESS, ERROR
    }

    companion object {
        fun <T> success(data: T?): Resource<T> {
            return Resource(Status.SUCCESS, data)
        }

        fun <T> error(exception: Throwable?, data: T? = null): Resource<T> {
            return Resource(
                Status.ERROR,
                data,
                exception
            )
        }
    }

    fun <T> transform(data: T? = null): Resource<T> {
        return Resource(status, data, exception)
    }
}