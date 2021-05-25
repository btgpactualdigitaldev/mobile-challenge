package br.com.btg.test.data


data class Resource<out T>(val status: Status, val data: T?, val message: String?) {

    companion object {

        fun <T> success(data: T?): Resource<T> {
            return Resource(
                Status.SUCCESS,
                data,
                null
            )
        }

        fun <T> error(throwable: Throwable): Resource<Throwable> {
            return Resource(
                Status.ERROR,
                throwable,
                null
            )
        }

        fun <T> error(message: String): Resource<T> {
            return Resource(
                Status.ERROR,
                null,
                message
            )
        }

        fun <T> loading(): Resource<T> {
            return Resource(
                Status.LOADING,
                null,
                null
            )
        }

        fun <T> empty(): Resource<T> {
            return Resource(
                Status.EMPTY,
                null,
                null
            )
        }
    }
}

enum class Status {
    SUCCESS,
    ERROR,
    EMPTY,
    LOADING
}
