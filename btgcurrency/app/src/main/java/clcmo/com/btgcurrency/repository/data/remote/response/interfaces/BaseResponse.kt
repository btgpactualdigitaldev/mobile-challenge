package clcmo.com.btgcurrency.repository.data.remote.response.interfaces

interface BaseResponse {
    val success: Boolean
    val error: ErrorResponse?
}

