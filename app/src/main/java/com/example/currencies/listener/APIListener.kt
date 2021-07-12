package com.example.currencies.listener

interface APIListener<T> {

    fun onSuccess(model: T)

    fun onFailure(str: String)

}