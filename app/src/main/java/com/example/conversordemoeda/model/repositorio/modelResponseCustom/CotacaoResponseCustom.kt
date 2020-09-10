package com.example.conversordemoeda.model.repositorio.modelResponseCustom

import com.example.conversordemoeda.model.repositorio.ResponseCustom
import com.example.conversordemoeda.model.repositorio.STATUS

class CotacaoResponseCustom(
    var valorConvertido: Float = 0F,
    errorMessage: String = "",
    status: STATUS
) : ResponseCustom(errorMessage, status)