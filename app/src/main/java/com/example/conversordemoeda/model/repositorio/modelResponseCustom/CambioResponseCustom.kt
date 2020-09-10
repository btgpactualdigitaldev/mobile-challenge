package com.example.conversordemoeda.model.repositorio.modelResponseCustom

import com.example.conversordemoeda.model.repositorio.ResponseCustom
import com.example.conversordemoeda.model.repositorio.STATUS

class CambioResponseCustom(
    var cambioMap: HashMap<String, String> = hashMapOf(),
    errorMessage: String = "",
    status: STATUS
) : ResponseCustom(errorMessage, status)