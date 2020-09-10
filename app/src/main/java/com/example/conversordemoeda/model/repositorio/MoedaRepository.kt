package com.example.conversordemoeda.model.repositorio

import com.example.conversordemoeda.model.entidades.Cambio
import com.example.conversordemoeda.model.entidades.Cotacao
import com.example.conversordemoeda.model.retrofit.CallbackResponse

interface MoedaRepository {
    fun getCambio(callbackResponse: CallbackResponse<Cambio>)
    fun getContacao(callbackResponse: CallbackResponse<Cotacao>)
}