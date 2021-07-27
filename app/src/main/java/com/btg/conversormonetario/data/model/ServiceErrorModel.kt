package com.btg.conversormonetario.data.model

import okhttp3.ResponseBody

open class ServiceErrorModel(
    var httpCode: Int = 0,
    var throwable: ResponseBody? = null,
    var response: ErrorModel? = null
)