package com.example.conversordemoeda.model.entidades

import com.example.conversordemoeda.model.repositorio.ServerError

open class BaseResponse (
    var success: Boolean,
    var terms:String,
    var privacy: String,
    var error: ServerError
)