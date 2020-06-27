package com.btg.converter.domain.entity.error

sealed class RequestException constructor(
    val errorMessage: String?,
    val httpErrorType: HttpErrorType?
) : Exception() {

    class HttpError(errorCode: Int, message: String? = null) :
        RequestException(message, HttpErrorType.getErrorForCode(errorCode))

    class NetworkError : RequestException(null, null)

    class TimeoutError : RequestException(null, null)

    class UnexpectedError(throwable: Throwable) : RequestException(throwable.message, null)
}