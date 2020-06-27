package com.btg.converter.domain.entity.error

enum class HttpErrorType {
    BAD_REQUEST,
    UNAUTHORIZED,
    FORBIDDEN,
    NOT_FOUND,
    TIMEOUT,
    CONFLICT,
    UN_PROCESSABLE_ENTITY,
    INTERNAL_SERVER_ERROR,
    UNEXPECTED_ERROR;

    companion object {
        fun getErrorForCode(errorCode: Int?): HttpErrorType {
            errorCode?.let {
                return when (it) {
                    400 -> BAD_REQUEST
                    401 -> UNAUTHORIZED
                    403 -> FORBIDDEN
                    404 -> NOT_FOUND
                    408 -> TIMEOUT
                    409 -> CONFLICT
                    422 -> UN_PROCESSABLE_ENTITY
                    500 -> INTERNAL_SERVER_ERROR
                    else -> UNEXPECTED_ERROR
                }
            }
            return UNEXPECTED_ERROR
        }
    }
}