package com.example.conversordemoeda.model.entidades

import com.example.conversordemoeda.model.repositorio.ServerError

class Cambio(
    var currencies: HashMap<String, String>,
    success: Boolean,
    terms: String,
    privacy: String,
    error: ServerError
) : BaseResponse(success, terms, privacy, error)