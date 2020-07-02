package com.test.core

import java.lang.IllegalStateException

data class ResponseCodeException(val responseCode: Int) : IllegalStateException()