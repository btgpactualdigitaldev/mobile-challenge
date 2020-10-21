package com.romildosf.currencyconverter.util

open class NetworkCallException(override val code: String, override val message: String): BaseException(code, message)