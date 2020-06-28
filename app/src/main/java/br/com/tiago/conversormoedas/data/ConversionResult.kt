package br.com.tiago.conversormoedas.data

sealed class ConversionResult {
    class Success(val rate: Float) : ConversionResult()
    class ApiError(val statusCode: Int) : ConversionResult()
    object ServerError: ConversionResult()
}