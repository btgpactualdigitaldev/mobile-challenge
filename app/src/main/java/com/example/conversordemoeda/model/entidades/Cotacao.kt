package com.example.conversordemoeda.model.entidades

import com.example.conversordemoeda.model.repositorio.ServerError

class Cotacao(
    success: Boolean,
    terms: String,
    privacy: String,
    error: ServerError,
    var timestamp:Long,
    var source:String,
    var quotes: HashMap<String, Float>
): BaseResponse(success, terms, privacy, error)