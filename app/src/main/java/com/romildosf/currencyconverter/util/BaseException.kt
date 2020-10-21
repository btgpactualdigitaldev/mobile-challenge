package com.romildosf.currencyconverter.util

open class BaseException(open val code: String, override val message: String): Exception() {

    override fun toString(): String {
        return "{code: $code, message: $message}"
    }
}
