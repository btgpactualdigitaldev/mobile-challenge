package com.hotmail.fignunes.btg.repository.remote.error

enum class GenericErrorCode(val code: Int) {
    UNAVAILABLE_SERVICE(404),
    ERROR_UNEXPECTED(500)
}