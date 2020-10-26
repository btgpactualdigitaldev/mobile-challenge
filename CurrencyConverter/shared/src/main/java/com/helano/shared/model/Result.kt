package com.helano.shared.model

import com.helano.shared.enums.Error

data class Result(
    var success: Boolean = false,
    var error: Error? = null
)