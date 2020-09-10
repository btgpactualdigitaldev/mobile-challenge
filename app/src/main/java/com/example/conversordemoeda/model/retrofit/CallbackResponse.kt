package com.example.conversordemoeda.model.retrofit

interface CallbackResponse<T> {
    fun success(response: T)

    fun failure(mensagem: String)
}