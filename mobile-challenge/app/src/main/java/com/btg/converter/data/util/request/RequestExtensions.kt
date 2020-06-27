package com.btg.converter.data.util.request

suspend fun <RESULT> handleException(
    exceptionHandler: suspend (Throwable) -> RESULT?,
    block: suspend () -> RESULT?
): RESULT? {
    return try {
        block()
    } catch (e: Exception) {
        exceptionHandler(e)
    }
}