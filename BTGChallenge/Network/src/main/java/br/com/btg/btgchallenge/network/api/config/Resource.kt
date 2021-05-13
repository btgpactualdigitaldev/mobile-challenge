package br.com.btg.btgchallenge.network.api.config

import br.com.btg.btgchallenge.network.model.ApiResponse

data class Resource<T>(val status: Status, val data: ApiResponse<*>?, val message: String?) {
    companion object {
        fun <T> success(data: ApiResponse<T>?): Resource<T> {
            return Resource(
                Status.SUCCESS,
                data,
                null
            )
        }

        fun <T> error(message: String, data: ApiResponse<*>?): Resource<T> {
            var msg = message
            if(data?.error?.info != null)
            {
                msg = data?.error?.info.toString()
            }
            return Resource(
                Status.ERROR,
                data,
                msg
            )
        }

        fun <T> loading(): Resource<T> {
            return Resource(
                Status.LOADING,
                null,
                null
            )
        }
    }
}