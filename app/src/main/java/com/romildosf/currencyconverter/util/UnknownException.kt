package com.romildosf.currencyconverter.util

data class UnknownException(override val message: String): BaseException(ErrorCodes.UNKNOWN, message)
