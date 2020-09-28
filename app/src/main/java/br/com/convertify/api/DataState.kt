package br.com.convertify.api

class DataState<T> {
    var data: T? = null
    var isError = false
    var errorMessage: String? = null
}